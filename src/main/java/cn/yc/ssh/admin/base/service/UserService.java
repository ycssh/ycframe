package cn.yc.ssh.admin.base.service;

import java.util.List;
import java.util.Set;

import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Role;
import cn.yc.ssh.admin.base.mybatis.model.User;
import cn.yc.ssh.admin.base.util.Pagination;

import com.github.pagehelper.Page;

public interface UserService {

	/**
	 * 创建用户
	 * 
	 * @param user
	 */
	public User createUser(User user);

	public User updateUser(User user);

	public void deleteUser(Long userId);

	/**
	 * 修改密码
	 * 
	 * @param userId
	 * @param newPassword
	 */
	public void changePassword(Long userId, String newPassword);

	User findOne(Long userId);

	/**
	 * 根据用户名查找用户
	 * 
	 * @param username
	 * @return
	 */
	public User findByUsername(String username);

	/**
	 * 根据用户名查找其角色
	 * 
	 * @param username
	 * @return
	 */
	public Set<String> findRoles(String username);

	/**
	 * 根据用户名查找其权限
	 * 
	 * @param username
	 * @return
	 */
	public Set<String> findPermissions(String username);

	/**
	 * 条件查询
	 * 
	 * @param user
	 * @param cascade
	 *            是否级联查询子部门
	 * @param page
	 * @return
	 */
	public Page<User> find(User user, Boolean cascade, Pagination page);

	List<Role> findRolesByUse(Long userId);

	List<Resource> findResByUse(Long userId);

	/**
	 * 保存分配的角色
	 * 
	 * @param id
	 * @param roles
	 */
	public void saveRoles(Long id, String roles);

	/**
	 * 查找某个人的所有角色
	 * 
	 * @param id
	 * @return
	 */
	public List<Role> findRolesByUser(Long id);

	public void updateState(int i, String username);

}