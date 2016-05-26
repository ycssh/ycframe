package cn.yc.ssh.admin.base.service;

import java.util.List;

import cn.yc.ssh.admin.base.mybatis.model.Organization;
import cn.yc.ssh.admin.base.util.Pagination;

import com.github.pagehelper.Page;

public interface OrganizationService {

	public Organization createOrganization(Organization organization);

	public Organization updateOrganization(Organization organization);

	public void deleteOrganization(Long organizationId);

	Organization findOne(Long organizationId);

	List<Organization> findAll();

	public List<Organization> findByParent(Long parentId);

	public Page<Organization> find(Organization organization, Pagination page);

	public Page<Organization> findByPID(Long pId, Pagination page);
}
