package cn.yc.ssh.admin.base.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.yc.ssh.admin.base.mybatis.mapper.ResourceMapper;
import cn.yc.ssh.admin.base.mybatis.mapper.RoleMapper;
import cn.yc.ssh.admin.base.mybatis.mapper.UserMapper;
import cn.yc.ssh.admin.base.mybatis.mapper.UserRoleMapper;
import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Role;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.mybatis.model.UserRole;
import cn.yc.ssh.admin.base.service.RoleService;
import cn.yc.ssh.admin.base.service.UserService;
import cn.yc.ssh.admin.base.util.Pagination;

import com.github.pagehelper.Page;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private PasswordHelper passwordHelper;
	@Autowired
	private RoleService roleService;
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private ResourceMapper resourceMapper;

	/**
	 * 创建用户
	 * 
	 * @param user
	 */
	public User createUser(User user) {
		// 加密密码
		passwordHelper.encryptPassword(user);
		Long id = userMapper.insert(user);
		return userMapper.selectByPrimaryKey(id);
	}

	
	public User updateUser(User user) {
		if(user.getPassword()!=null){
			passwordHelper.encryptPassword(user);
		}
		userMapper.updateByPrimaryKeySelective(user);
		return user;
	}

	
	public void deleteUser(Long id) {
		userMapper.deleteByPrimaryKey(id);
	}

	/**
	 * 修改密码
	 * 
	 * @param userId
	 * @param newPassword
	 */
	public void changePassword(Long userId, String newPassword) {
		User user = userMapper.selectByPrimaryKey(userId);
		user.setPassword(newPassword);
		passwordHelper.encryptPassword(user);
		user.setUpdateTime(new Date());
		userMapper.updateByPrimaryKeySelective(user);
	}

	
	public User findOne(Long userId) {
		return userMapper.selectByPrimaryKey(userId);
	}

	/**
	 * 根据用户名查找用户
	 * 
	 * @param username
	 * @return
	 */
	public User findByUsername(String username) {
		User user = new User();
		user.setUsername(username);
		return userMapper.findByUsername(username);
	}

	/**
	 * 根据用户名查找其角色
	 * 
	 * @param username
	 * @return
	 */
	public Set<String> findRoles(String username) {
		User user = findByUsername(username);
		if (user == null) {
			return Collections.emptySet();
		}

		List<Role> roles =  findRolesByUse(user.getId());
		Set<String> set = new HashSet<String>();
		for(Role role:roles){
			set.add(role.getRole());
		}
		return set;
	}

	/**
	 * 根据用户名查找其权限
	 * 
	 * @param username
	 * @return
	 */
	public Set<String> findPermissions(String username) {
		User user = findByUsername(username);
		if (user == null) {
			return Collections.emptySet();
		}
		List<Resource> resources = resourceMapper.selectByUser(user.getId());
		Set<String> set = new HashSet<String>();
		for(Resource resource:resources){
			set.add(resource.getPermission());
		}
		return set;
		
	}

	
	public Page<User> find(User user, Boolean cascade, Pagination page) {
		RowBounds bounds = new RowBounds(page.getPage(),page.getRows());
		return userMapper.select(user, bounds);
	}

	public List<Role> findRolesByUse(Long userId) {
		return roleMapper.selectByUser(userId);
	}

	public List<Resource> findResByUse(Long userId) {
		return resourceMapper.selectByUser(userId);
	}

	
	public void saveRoles(Long id, String roles) {
		userRoleMapper.deleteByUser(id);
		if(StringUtils.hasLength(roles)){
			List<UserRole> userRoles = new ArrayList<UserRole>();
			for(String role:roles.split(",")){
				if(StringUtils.hasLength(role)){
					UserRole userRole = new UserRole();
					userRole.setUserId(id);
					userRole.setRoleId(Long.parseLong(role));
					userRoles.add(userRole);
				}
			}
			if(userRoles.size()>0)
			userRoleMapper.insertBatch(userRoles);
		}
	}

	
	public List<Role> findRolesByUser(Long userId) {
		return roleMapper.selectByUser(userId);
	}

	
	public void updateState(int i, String username) {
		User user = findByUsername(username);
		user.setLocked((long)i);
		userMapper.updateByPrimaryKeySelective(user);
	}

}