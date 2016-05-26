package cn.yc.ssh.admin.base.mybatis.mapper;

import java.util.List;

import cn.yc.ssh.admin.base.mybatis.model.RoleResource;
import cn.yc.ssh.admin.base.mybatis.model.RoleResourceKey;

public interface RoleResourceMapper {
    int deleteByPrimaryKey(RoleResourceKey key);

    int insert(RoleResource record);

    int insertSelective(RoleResource record);

    RoleResource selectByPrimaryKey(RoleResourceKey key);

    int updateByPrimaryKeySelective(RoleResource record);

    int updateByPrimaryKey(RoleResource record);

	void deleteByRole(Long roleId);

	void insertBatch(List<RoleResource> userRoles);
}