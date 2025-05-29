package model;

import java.io.Serializable;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the rewards_discipline database table.
 *
 */
@Entity
@Table(name="rewards_discipline")
@NamedQuery(name="RewardsDiscipline.findAll", query="SELECT r FROM RewardsDiscipline r")
public class RewardsDiscipline implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="record_id")
	private int recordId;

	@Column(name="employee_id")
	private int employeeId;

	@Column(name="date_recorded")
	private LocalDate dateRecorded;

	@Lob
	private String description;

	private String title;

	private String type;

	public int getRecordId() {
		return this.recordId;
	}

	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}

	public LocalDate getDateRecorded() {
		return this.dateRecorded;
	}

	public void setDateRecorded(LocalDate dateRecorded) {
		this.dateRecorded = dateRecorded;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getEmployeeId()
	{
		return this.employeeId;
	}

	public void setEmployeeId(int empId)
	{
		this.employeeId=empId;
	}


}