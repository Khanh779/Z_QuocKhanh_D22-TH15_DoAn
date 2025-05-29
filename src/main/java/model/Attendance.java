package model;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the attendance database table.
 *
 */
@Entity
@Table(name="attendance")
@NamedQuery(name="Attendance.findAll", query="SELECT a FROM Attendance a")
public class Attendance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="attendance_id")
	private int attendanceId;

	@Column(name="check_in")
	private Time checkIn;

	@Column(name="check_out")
	private Time checkOut;

	@Temporal(TemporalType.DATE)
	private Date date;


	@Column(name="employee_id")
	private int employeeId;

	public Attendance() {
	}

	public int getAttendanceId() {
		return this.attendanceId;
	}

	public void setAttendanceId(int attendanceId) {
		this.attendanceId = attendanceId;
	}

	public Time getCheckIn() {
		return this.checkIn;
	}

	public void setCheckIn(Time checkIn) {
		this.checkIn = checkIn;
	}

	public Time getCheckOut() {
		return this.checkOut;
	}

	public void setCheckOut(Time checkOut) {
		this.checkOut = checkOut;
	}

	public Date getDate() {
		return this.date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getEmployeeId() {
		return this.employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

}