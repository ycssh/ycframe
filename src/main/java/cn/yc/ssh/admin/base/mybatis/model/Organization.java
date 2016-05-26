package cn.yc.ssh.admin.base.mybatis.model;

import java.lang.Long;

public class Organization {
    private Long id;

    private String name;

    private Long parentId;

    private String power;

	public Organization(){}
	
	public Organization(Long id,String name){
    	this.id = id;
    	this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power == null ? null : power.trim();
    }
}