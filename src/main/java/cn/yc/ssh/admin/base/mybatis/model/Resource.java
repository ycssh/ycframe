package cn.yc.ssh.admin.base.mybatis.model;

import java.util.List;


public class Resource {
    private Long id;

    private String name;

    private String url;

    private Long parentId;

    private String type;

    private String permission;

    private String showinfront;

    private String picname;
    private Boolean isParent ;
    
    private String state;
    private List<Resource> children;

    private Long resType;

	public static enum ResourceType {
        menu("菜单"), button("按钮");

        private final String info;
        private ResourceType(String info) {
            this.info = info;
        }

        public String getInfo() {
            return info;
        }
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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission == null ? null : permission.trim();
    }

    public String getShowinfront() {
        return showinfront;
    }

    public void setShowinfront(String showinfront) {
        this.showinfront = showinfront == null ? null : showinfront.trim();
    }

    public String getPicname() {
        return picname;
    }

    public void setPicname(String picname) {
        this.picname = picname == null ? null : picname.trim();
    }

    public Long getResType() {
        return resType;
    }

    public boolean isRootNode() {
        return parentId == 0;
    }
    
    public void setResType(Long resType) {
        this.resType = resType;
    }

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}

	public void setChildren(List<Resource> children) {
		this.children = children;
	}

	public List<Resource> getChildren() {
		return children;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
    
    
}