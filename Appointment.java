
public class Appointment {
	
	private String time;
	private String name;
	private String hcardid;
	private int appt_id;
	private boolean isPrimary;
	private int preg_id;
	
	public Appointment(String time, String name, String hcardid, int appt_id, boolean isPrimary, int preg_id) {
		
		this.time = time;
		this.name = name;
		this.hcardid = hcardid;
		this.appt_id = appt_id;
		this.preg_id = preg_id;
		this.isPrimary = isPrimary;
	}

	public int getPreg_id() {
		return preg_id;
	}

	public void setPreg_id(int preg_id) {
		this.preg_id = preg_id;
	}

	public boolean isPrimary() {
		return isPrimary;
	}

	public void setPrimary(boolean isPrimary) {
		this.isPrimary = isPrimary;
	}

	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHcardid() {
		return hcardid;
	}
	public void setHcardid(String hcardid) {
		this.hcardid = hcardid;
	}
	public int getAppt_id() {
		return appt_id;
	}
	public void setAppt_id(int appt_id) {
		this.appt_id = appt_id;
	}


	@Override
	public String toString() {
		return "Appointment [ time=" + time + ", name=" + name + ", hcardid=" + hcardid + ", appt_id="
				+ appt_id + ", isPrimary=" + isPrimary + "]";
	}
	
	
	
	
}
