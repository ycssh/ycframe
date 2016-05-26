package cn.yc.ssh.admin.base.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yc.ssh.admin.base.mybatis.mapper.SysInitMapper;
import cn.yc.ssh.admin.base.mybatis.model.SysInit;
import cn.yc.ssh.admin.base.service.SysInitService;

@Service
public class SysInitServiceImpl implements SysInitService {

    @Autowired
    private SysInitMapper sysInitMapper;
	
	public void update(int id, String value) {
		SysInit init = new SysInit();
		init.setId(id);
		init.setValue(value);
		sysInitMapper.updateByPrimaryKeySelective(init);
	}

}
