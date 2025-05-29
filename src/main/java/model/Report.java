package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the reports database table.
 *
 */
@Entity
@Table(name="reports")
@NamedQuery(name="Report.findAll", query="SELECT r FROM Report r")
public class Report implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int reportId;

	@Temporal(TemporalType.TIMESTAMP)
	private Date creationDateTime;

	@Lob
	private String reportDescription;

	@Lob
	private String reportName;

	private String reportType;

	public Report() {
	}

	public int getReportId() {
		return this.reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public Date getCreationDateTime() {
		return this.creationDateTime;
	}

	public void setCreationDateTime(Date creationDateTime) {
		this.creationDateTime = creationDateTime;
	}

	public String getReportDescription() {
		return this.reportDescription;
	}

	public void setReportDescription(String reportDescription) {
		this.reportDescription = reportDescription;
	}

	public String getReportName() {
		return this.reportName;
	}

	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	public String getReportType() {
		return this.reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

}