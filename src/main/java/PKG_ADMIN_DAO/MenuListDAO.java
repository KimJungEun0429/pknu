package PKG_ADMIN_DAO;

public class MenuListDAO {

	private String MenuID;
	private String MenuName;
	private String MenuSeq;
	private String MenuLvl;
	private String ParentID;
	
	
	public String getMenuID() {
		return MenuID;
	}
	public void setMenuID(String menuID) {
		MenuID = menuID;
	}
	public String getMenuName() {
		return MenuName;
	}
	public void setMenuName(String menuName) {
		MenuName = menuName;
	}
	public String getMenuSeq() {
		return MenuSeq;
	}
	public void setMenuSeq(String menuSeq) {
		MenuSeq = menuSeq;
	}
	public String getMenuLvl() {
		return MenuLvl;
	}
	public void setMenuLvl(String menuLvl) {
		MenuLvl = menuLvl;
	}
	public String getParentID() {
		return ParentID;
	}
	public void setParentID(String parentID) {
		ParentID = parentID;
	}

}
