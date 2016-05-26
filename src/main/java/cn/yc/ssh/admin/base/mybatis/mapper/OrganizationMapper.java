package cn.yc.ssh.admin.base.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import cn.yc.ssh.admin.base.mybatis.model.Organization;

import com.github.pagehelper.Page;

public interface OrganizationMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Organization record);

    int insertSelective(Organization record);

    Organization selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Organization record);

    int updateByPrimaryKey(Organization record);

	List<Organization> findAll();

	List<Organization> findByParent(Long parentId);

	Page<Organization> find(Organization organization, RowBounds rowBounds);

	Page<Organization> findByPID(Long pId, RowBounds rowBounds);
}