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
 * The persistent class for the contracts database table.
 *
 */
@Entity
@Table(name="contracts")
@NamedQuery(name="Contract.findAll", query="SELECT c FROM Contract c")
public class Contract implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="contract_id")
	private int contractId;

	@Column(name="contract_type")
	private String contractType;

	@Column(name="end_date")
	private LocalDate endDate;

	@Lob
	private String note;

	@Column(name="start_date")
	private LocalDate startDate;

	@Column(name="employee_id")
	private int employeeId;

	public Contract() {
	}

	public int getContractId() {
		return this.contractId;
	}

	public void setContractId(int contractId) {
		this.contractId = contractId;
	}

	public String getContractType() {
		return this.contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	public LocalDate getEndDate() {
		return this.endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public LocalDate getStartDate() {
		return this.startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public int getEmployeeId() {
		return this.employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

}