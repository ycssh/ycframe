package cn.yc.ssh.admin.base.service;

import java.util.List;
import java.util.Set;

import cn.yc.ssh.admin.base.mybatis.model.Resource;
import cn.yc.ssh.admin.base.mybatis.model.Role;
import cn.yc.ssh.admin.base.util.Pagination;

import com.github.pagehelper.Page;

public interface RoleService {


    public Role createRole(Role role);
    public Role updateRole(Role role);
    public void deleteRole(Long roleId);

    public Role findOne(Long roleId);
    public List<Role> findAll();

    /**
     * 根据角色编号得到角色标识符列表
     * @param roleIds
     * @return
     */
    Set<String> findRoles(Long... roleIds);

    /**
     * 根据角色编号得到权限字符串列表
     * @param roleIds
     * @return
     */
    Set<String> findPermissions(Long[] roleIds);
	public List<Resource> findResByRole(Long roleId);
	
	/**
	 * 分页查询
	 * @param page
	 * @param role
	 * @return
	 */
	public Page<Role> find(Pagination page, Role role);
	
	public void saveResources(Long roleId, String resources);
	
	public List<Role> listAll();
	
	
	//获取当前用户可看到资源类型
	public String resTypeForNowUser(long userId);
	//根据角色ID,获取角色信息
	public Role getRoleByroleId(Long roleId);
	//根据角色ID，角色状态，对角色进行审核
	public int rolePass(Long roleId ,String stateId);
}