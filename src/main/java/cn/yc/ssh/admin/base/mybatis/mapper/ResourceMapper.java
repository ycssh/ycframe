package cn.yc.ssh.admin.base.mybatis.mapper;

import java.util.List;

import cn.yc.ssh.admin.base.mybatis.model.Resource;

public interface ResourceMapper {
    int deleteByPrimaryKey(Long id);

    Long insert(Resource record);

    Long insertSelective(Resource record);

    Resource selectByPrimaryKey(Long id);
    
    List<Resource> selectAll();

    int updateByPrimaryKeySelective(Resource record);

    int updateByPrimaryKey(Resource record);

	List<Resource> selectByParent(Long resourceId);

	List<Resource> selectByUser(Long id);

	List<Resource> selectByRole(Long roleId);
}