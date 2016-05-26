package cn.yc.ssh.admin.base.service;

import java.util.List;
import java.util.Set;

import cn.yc.ssh.admin.base.mybatis.model.Resource;

public interface ResourceService {

	Resource createResource(Resource resource);

	Resource updateResource(Resource resource);

	void deleteResource(Long resourceId);

	Resource findOne(Long resourceId);

	List<Resource> findAll();

	Set<String> findPermissions(Set<Long> resourceIds);

	List<Resource> findMenus(Set<String> permissions);

	List<Resource> findMenus(Set<String> permissions, Long resourceId);

	public String hasChildren(Long resourceId);

	public List<Resource> tree();

	public void removeByIds(String ids);
}