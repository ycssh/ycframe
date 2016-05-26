package cn.yc.ssh.admin.base.mybatis.mapper;

import org.apache.ibatis.session.RowBounds;

import cn.yc.ssh.admin.base.mybatis.model.User;

import com.github.pagehelper.Page;

public interface UserMapper {
    int deleteByPrimaryKey(Long id);

    Long insert(User record);

    Long insertSelective(User record);

    User selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    Page<User> select(User user, RowBounds bounds);
    
    int selectCount(User user);

	User findByUsername(String username);
}