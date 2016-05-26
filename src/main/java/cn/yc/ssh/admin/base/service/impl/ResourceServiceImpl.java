package cn.yc.ssh.admin.base.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.yc.ssh.admin.Constants;
import cn.yc.ssh.admin.base.mybatis.mapper.ResourceMapper;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.service.ResourceService;

@Service
public class ResourceServiceImpl implements ResourceService {

	@Autowired
	private ResourceMapper resourceMapper;

	
	public Resource createResource(Resource resource) {
		resourceMapper.insert(resource);
		return resource;
	}

	
	public Resource updateResource(Resource resource) {
		resourceMapper.updateByPrimaryKeySelective(resource);
		return resource;
	}

	
	public void deleteResource(Long resourceId) {
		resourceMapper.deleteByPrimaryKey(resourceId);
	}

	
	public Resource findOne(Long resourceId) {
		return resourceMapper.selectByPrimaryKey(resourceId);
	}

	
	public List<Resource> findAll() {
		List<Resource> resources = resourceMapper.selectAll();

		List<Resource> resources2 = new ArrayList<Resource>();
		Set<Long> set = new HashSet<Long>();
		for (Resource resource : resources) {
			while (!set.contains(resource.getId())) {
				set.add(resource.getId());
				List<Resource> children = new ArrayList<Resource>();
				for (Resource resource2 : resources) {
					if (resource2.getParentId().equals(resource.getId())) {
						children.add(resource2);
						resource.setState("closed");
					}
				}
				resource.setChildren(children);
			}
			if (resource.getParentId() == 0) {
				resources2.add(resource);
			}
		}
		return resources2;
	}

	
	public Set<String> findPermissions(Set<Long> resourceIds) {
		Set<String> permissions = new HashSet<String>();
		for (Long resourceId : resourceIds) {
			Resource resource = findOne(resourceId);
			if (resource != null
					&& !StringUtils.isEmpty(resource.getPermission())) {
				permissions.add(resource.getPermission());
			}
		}
		return permissions;
	}

	
	public List<Resource> findMenus(Set<String> permissions) {
		List<Resource> allResources = findAll();
		List<Resource> menus = new ArrayList<Resource>();
		for (Resource resource : allResources) {
			if (resource.isRootNode()) {
				continue;
			}
			if (!"menu".equals(resource.getType())) {
				continue;
			}
			if (!hasPermission(permissions, resource)) {
				continue;
			}
			menus.add(resource);
		}
		return menus;
	}

	
	public List<Resource> findMenus(Set<String> permissions, Long resourceId) {
		List<Resource> allResources = resourceMapper.selectByParent(resourceId);
		List<Resource> menus = new ArrayList<Resource>();
		for (Resource resource : allResources) {
			if (!"menu".equals(resource.getType())) {
				continue;
			}
			if (!hasPermission(permissions, resource)) {
				continue;
			}
			if (!StringUtils.hasLength(resource.getUrl())) {
				resource.setIsParent(true);
			}
			menus.add(resource);
		}
		return menus;
	}

	private boolean hasPermission(Set<String> permissions, Resource resource) {
		if (StringUtils.isEmpty(resource.getPermission())) {
			return true;
		}
		for (String permission : permissions) {
			WildcardPermission p1 = new WildcardPermission(permission);
			WildcardPermission p2 = new WildcardPermission(
					resource.getPermission());
			if (p1.implies(p2) || p2.implies(p1)) {
				return true;
			}
		}
		return false;
	}

	
	public String hasChildren(Long resourceId) {
		String state = Constants.TREE_CLOSE;
		List<Resource> list = resourceMapper.selectByParent(resourceId);
		for(Resource r:list){
			if("menu".equals(r.getType())){
				return state;
			}
		}
		return Constants.TREE_OPEN;
	}

	
	public List<Resource> tree() {
		List<Resource> resources = resourceMapper.selectAll();
		List<Resource> resources2 = new ArrayList<Resource>();
		Set<Long> set = new HashSet<Long>();
		for (Resource resource : resources) {
			while (!set.contains(resource.getId())) {
				set.add(resource.getId());
				List<Resource> children = new ArrayList<Resource>();
				for (Resource resource2 : resources) {
					if (resource2.getParentId().equals(resource.getId())) {
						children.add(resource2);
					}
				}
				resource.setChildren(children);
				resource.setState("closed");
			}
			if (resource.getParentId() == 0) {
				resources2.add(resource);
			}
		}
		return resources2;
	}


	
	public void removeByIds(String ids) {
		String[] arr = ids.split(",");
		for(String id:arr){
			resourceMapper.deleteByPrimaryKey(Long.parseLong(id));
		}
	}

}
