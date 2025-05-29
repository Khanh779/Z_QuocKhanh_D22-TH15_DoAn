package model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;

/**
 * The persistent class for the salary database table.
 */
@Entity
@NamedQuery(name="Salary.findAll", query="SELECT s FROM Salary s")
public class Salary implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="salary_id", nullable = false, updatable = false)
	private int salaryId;

	@Column(nullable = false)
	private double allowance = 0f;  // mặc định 0

	@Column(name="basic_salary", nullable = false, precision = 10, scale = 2)
	private double basicSalary;

	@Column(precision = 10, scale = 2)
	private double bonus = 0f; // mặc định 0

	@Column(precision = 10, scale = 2)
	private double deduction = 0f; // mặc định 0

	@Column(nullable = false)
	private int month;

	@Column(name="total_salary", nullable = false, precision = 10, scale = 2)
	private double totalSalary;

	@Column(nullable = false)
	private int year;

	@Column(name="employee_id", nullable = false)
	private int employeeId;

	public Salary() {
	}

	public int getSalaryId() {
		return this.salaryId;
	}

	public void setSalaryId(int salaryId) {
		this.salaryId = salaryId;
	}

	public double getAllowance() {
		return this.allowance;
	}

	public void setAllowance(double allowance) {
		this.allowance = allowance;
	}

	public double getBasicSalary() {
		return this.basicSalary;
	}

	public void setBasicSalary(double basicSalary) {
		this.basicSalary = basicSalary;
	}

	public double getBonus() {
		return this.bonus;
	}

	public void setBonus(double bonus) {
		this.bonus = bonus;
	}

	public double getDeduction() {
		return this.deduction;
	}

	public void setDeduction(double deduction) {
		this.deduction = deduction;
	}

	public int getMonth() {
		return this.month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public double getTotalSalary() {
		return this.totalSalary;
	}

	public void setTotalSalary(double totalSalary) {
		this.totalSalary = totalSalary;
	}

	public int getYear() {
		return this.year;
	}

	public void setYear(int i) {
		this.year = i;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
}
