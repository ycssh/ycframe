package cn.yc.ssh.admin.base.mybatis.model;

import java.lang.Long;

public class RoleResourceKey {
    private Long roleId;

    private Long resourceId;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getResourceId() {
        return resourceId;
    }

    public void setResourceId(Long resourceId) {
        this.resourceId = resourceId;
    }
}