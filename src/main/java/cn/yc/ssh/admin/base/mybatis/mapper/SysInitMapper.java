package cn.yc.ssh.admin.base.mybatis.mapper;

import cn.yc.ssh.admin.base.mybatis.model.SysInit;

public interface SysInitMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysInit record);

    int insertSelective(SysInit record);

    SysInit selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysInit record);

    int updateByPrimaryKey(SysInit record);
}