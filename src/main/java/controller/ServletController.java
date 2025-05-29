package controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AttendanceDao;
import dao.ContractDao;
import dao.DepartmentDao;
import dao.EmployeeDao;
import dao.LeaveDao;
import dao.RewardDisciplineDao;
import dao.SalaryDao;
import dao.UserDao;
import model.Attendance;
import model.Contract;
import model.Department;
import model.Employee;
import model.Leave;
import model.RewardsDiscipline;
import model.Salary;
import model.User;

/**
 * Servlet implementation class ServletController
 */
@WebServlet(urlPatterns = {
		"/login", "/main", "/home",

		"/employeeManager", "/addEmployee", "/deleteEmployee", "/editEmployee",

		"/departmentManager", "/addDepartment", "/deleteDepartment", "/editDepartment",

		"/attendanceManager", "/addAttendance", "/deleteAttendance", "/editAttendance",

		"/salaryManager", "/addSalary", "/deleteSalary", "/editSalary",

		"/leaveManager", "/addLeave", "/deleteLeave", "/editLeave",

		"/contractManager", "/addContract", "/deleteContract", "/editContract",

		"/rewardManager", "/addRewardDiscipline", "/deleteRewardDiscipline", "/editRewardDiscipline",

		"/userManager", "/addUser", "/deleteUser", "/editUser", // Hãy xoá khi thầy kiểm tra

		"/viewReport",

		"/logout" })
public class ServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserDao userDao = new UserDao();
	private EmployeeDao employeeDao = new EmployeeDao();
	private DepartmentDao departmentDao = new DepartmentDao();

	private AttendanceDao attendanceDao = new AttendanceDao(); // Chấm công
	private ContractDao contractDao = new ContractDao(); // Hợp đồng
	private LeaveDao leaveDao = new LeaveDao(); // Nghỉ
	private RewardDisciplineDao rewardDisciplineDao = new RewardDisciplineDao(); // Khen thưởng
	private SalaryDao salaryDao = new SalaryDao(); // Lương

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletController() {
		super();
		// TODO Auto-generated constructor stub
	}

	User user = null;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setDateHeader("Expires", 0); // Proxies

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		session.setAttribute("isFailed", false);
		
	

		String action = request.getServletPath();

		try {

			switch (action) {

				case "/login":

					if (!userDao.getLoginStatus()) {
						String username = request.getParameter("username");
						String password = request.getParameter("password");

						if (username != null && password != null && !username.isEmpty() && !password.isEmpty()) {
							boolean check = userDao.checkLogin(username, password);
							if (check) {
								userDao.setLoginStatus(true);
								user = userDao.getUserByUsername(username);
								session.setAttribute("user", user);
								response.sendRedirect("main");
							} else {
								session.setAttribute("isFailed", true);
								request.getRequestDispatcher("index.jsp").forward(request, response);
							}
						} else {
							userDao.setLoginStatus(false);
							session.setAttribute("isFailed", true);
							request.getRequestDispatcher("index.jsp").forward(request, response);
						}
					} else {
						response.sendRedirect("main");
					}

					break;

				case "/main":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						session.setAttribute("user", user);
						request.getRequestDispatcher("main.jsp").forward(request, response);
					} else {
						response.sendRedirect("login");
					}
					break;

				case "/home":
					if (userDao.getLoginStatus()) {
						session.setAttribute("user", user);

						session.setAttribute("listUser", userDao.getAllUsers());
						session.setAttribute("listEmployee", employeeDao.getAllEmployees());
						session.setAttribute("listDepartment", departmentDao.getAllDepartments());
						session.setAttribute("listAttendance", attendanceDao.getAll());
						session.setAttribute("listSalary", salaryDao.getAllSalaries());
						session.setAttribute("listLeave", leaveDao.getAllLeaves());
						session.setAttribute("listContract", contractDao.getAll());
						session.setAttribute("listRewardsDiscipline", rewardDisciplineDao.getAll());

						request.getRequestDispatcher("page/homeForm.jsp").forward(request, response);
					}

					break;

				case "/employeeManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							
							session.setAttribute("errorMessage", "");
							session.setAttribute("listEmployee", employeeDao.getAllEmployees());
							request.getRequestDispatcher("page/listEmployee.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/addEmployee":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							String employeeName = request.getParameter("fullName");
							int departmentCode = Integer.parseInt(request.getParameter("departmentId"));

							String position = request.getParameter("position");
							String phoneNumber = (request.getParameter("phone"));
							String email = request.getParameter("email");
							String gender = request.getParameter("gender");
							LocalDate dob = (LocalDate.parse(request.getParameter("dob")));

							Employee employee = new Employee();
							employee.setFullName(employeeName);
							employee.setDepartmentId(departmentCode);
							employee.setPosition(position);
							employee.setPhone(phoneNumber);
							employee.setEmail(email);
							employee.setHireDate((LocalDate.parse(request.getParameter("hireDate"))));
							employee.setGender(gender);
							employee.setDob(dob);
							employee.setUserId(Integer.parseInt(request.getParameter("userId")));
							employee.setAddress(request.getParameter("address"));

							boolean isExists = employeeDao.getAllEmployees().stream()
		                               .anyMatch(e -> e.getUserId() == employee.getUserId());

							session.setAttribute("errorMessage", "");
							if(isExists)
							{
								session.setAttribute("errorMessage", "Lỗi, ko tồn tại id hoặc id đã tồn tại trước đó");
							}
							else {
								employeeDao.addEmployee(employee);
							}
							response.sendRedirect("employeeManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/deleteEmployee":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							employeeDao.deleteEmployee(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("employeeManager");
						} else {
							forbidden(request, response);
						}
					}

				case "/editEmployee":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int employeeId = Integer.parseInt(request.getParameter("id"));
							Employee employee = employeeDao.getEmployeeById(employeeId);

							employee.setFullName(request.getParameter("fullName"));
							employee.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
							employee.setPosition(request.getParameter("position"));
							employee.setPhone(request.getParameter("phone"));
							employee.setEmail(request.getParameter("email"));
							employee.setHireDate((LocalDate.parse(request.getParameter("hireDate"))));
							employee.setGender(request.getParameter("gender"));
							employee.setDob((LocalDate.parse(request.getParameter("dob"))));
							employee.setUserId(Integer.parseInt(request.getParameter("userId")));
							employee.setAddress(request.getParameter("address"));

							boolean isExists = employeeDao.getAllEmployees().stream()
		                               .anyMatch(e -> e.getUserId() == employee.getUserId());
//

							if(isExists)
							{
								session.setAttribute("errorMessage", "Lỗi, ko tồn tại id hoặc id đã tồn tại trước đó");
							}
							else {
								employeeDao.updateEmployee(employee);
							}
							response.sendRedirect("employeeManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/departmentManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							session.setAttribute("errorMessage", null);
							session.setAttribute("listDepartment", departmentDao.getAllDepartments());
							request.getRequestDispatcher("page/listDepartment.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/addDepartment":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							String departmentName = request.getParameter("name");
							Department department = new Department();
							department.setName(departmentName);

							String strEmpId = request.getParameter("employeeId");

							if (strEmpId != null && !strEmpId.trim().isEmpty()) {
							    strEmpId = strEmpId.trim();
							    department.setEmployeeId(Integer.parseInt(strEmpId));
							} else {
							    department.setEmployeeId(null); 
							}



							departmentDao.addDepartment(department);
							response.sendRedirect("departmentManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/deleteDepartment":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							departmentDao.deleteDepartment(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("departmentManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/editDepartment":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int departmentId = Integer.parseInt(request.getParameter("id"));
							Department department = departmentDao.getDepartmentById(departmentId);
							department.setName(request.getParameter("name"));


							String strEmpId = request.getParameter("employeeId");

							if (strEmpId != null && !strEmpId.trim().isEmpty()) {
							    strEmpId = strEmpId.trim();
							    department.setEmployeeId(Integer.parseInt(strEmpId));
							} else {
							    department.setEmployeeId(null); 
							}

							departmentDao.updateDepartment(department);
							response.sendRedirect("departmentManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/attendanceManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr", "employee")) {
							session.setAttribute("listAttendance", attendanceDao.getAll());
							request.getRequestDispatcher("page/listAttendance.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/addAttendance":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr", "employee")) {
							Attendance attendance = new Attendance();
							attendance.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							attendance.setDate(java.sql.Date.valueOf(LocalDate.parse(request.getParameter("date"))));
							
							LocalTime checkIn=LocalTime.parse(request.getParameter("checkIn"));
							LocalTime checkOut=LocalTime.parse(request.getParameter("checkOut"));
							
							//Duration.between(checkIn, checkOut);
							
							attendance.setCheckIn(
									java.sql.Time.valueOf(checkIn));
							attendance.setCheckOut(
									java.sql.Time.valueOf(checkOut));
							
							if(checkIn.isBefore(checkOut))
							{
								attendanceDao.add(attendance);
							}
							else {
								session.setAttribute("errorMessage", "Lỗi, thời gian ra phải lớn hơn thời gian vào");
							}
							
							response.sendRedirect("attendanceManager");
						}
					}

					break;

				case "/deleteAttendance":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							attendanceDao.delete(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("attendanceManager");
						}
					}

					break;

				case "/editAttendance":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int attendanceId = Integer.parseInt(request.getParameter("attendanceId"));
							Attendance attendance = attendanceDao.getAttendanceById(attendanceId);

							attendance.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							attendance.setDate(java.sql.Date.valueOf(LocalDate.parse(request.getParameter("date"))));

							LocalTime checkIn=LocalTime.parse(request.getParameter("checkIn"));
							LocalTime checkOut=LocalTime.parse(request.getParameter("checkOut"));
							
							attendance.setCheckIn(
									java.sql.Time.valueOf(checkIn));
							attendance.setCheckOut(
									java.sql.Time.valueOf(checkOut));
							
							if(checkIn.isBefore(checkOut))
							{
								attendanceDao.add(attendance);
							}
							else {
								session.setAttribute("errorMessage", "Lỗi, thời gian ra phải lớn hơn thời gian vào");
							}
							response.sendRedirect("attendanceManager");
						}
					}

					break;

				case "/salaryManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr", "employee")) {
							session.setAttribute("listSalary", salaryDao.getAllSalaries());
							request.getRequestDispatcher("page/listSalary.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/addSalary":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							Salary salary = new Salary();
							salary.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							salary.setBasicSalary(Double.parseDouble(request.getParameter("basicSalary")));
							salary.setAllowance(Double.parseDouble(request.getParameter("allowance")));
							salary.setBonus(Double.parseDouble(request.getParameter("bonus")));
							salary.setMonth(Integer.parseInt(request.getParameter("month")));
							salary.setYear(Integer.parseInt(request.getParameter("year")));
							salary.setDeduction(Double.parseDouble(request.getParameter("deduction")));

							double totalSalary = salary.getBasicSalary() + salary.getAllowance() + salary.getBonus()
									- salary.getDeduction();
							salary.setTotalSalary(totalSalary);
							salaryDao.addSalary(salary);
							response.sendRedirect("salaryManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/deleteSalary":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							salaryDao.deleteSalary(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("salaryManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/editSalary":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int salaryId = Integer.parseInt(request.getParameter("salaryId"));
							Salary salary = salaryDao.getSalaryById(salaryId);
							salary.setBasicSalary(Double.parseDouble(request.getParameter("basicSalary")));
							salary.setAllowance(Double.parseDouble(request.getParameter("allowance")));
							salary.setBonus(Double.parseDouble(request.getParameter("bonus")));
							salary.setDeduction(Double.parseDouble(request.getParameter("deduction")));
							salary.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							salary.setMonth(Integer.parseInt(request.getParameter("month")));
							salary.setYear(Integer.parseInt(request.getParameter("year")));

							double totalSalary = salary.getBasicSalary() + salary.getAllowance() + salary.getBonus()
									- salary.getDeduction();
							salary.setTotalSalary(totalSalary);

							salaryDao.updateSalary(salary);
							response.sendRedirect("salaryManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/leaveManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr", "employee")) {
							session.setAttribute("listLeave", leaveDao.getAllLeaves());
							request.getRequestDispatcher("page/listLeave.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/addLeave":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr", "employee")) {
							Leave leave = new Leave();
							leave.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							leave.setLeaveType(request.getParameter("leaveType"));
							leave.setStartDate(LocalDate.parse(request.getParameter("startDate")));
							leave.setEndDate(LocalDate.parse(request.getParameter("endDate")));
							leave.setStatus(request.getParameter("status"));

							leaveDao.addLeave(leave);
							response.sendRedirect("leaveManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/editLeave":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int leaveId = Integer.parseInt(request.getParameter("id"));
							Leave leave = leaveDao.getById(leaveId);
							leave.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							leave.setLeaveType(request.getParameter("leaveType"));
							leave.setStartDate(LocalDate.parse(request.getParameter("startDate")));
							leave.setEndDate(LocalDate.parse(request.getParameter("endDate")));
							leave.setStatus(request.getParameter("status"));

							leaveDao.updateLeave(leave);
							response.sendRedirect("leaveManager");
						} else {
							forbidden(request, response);
						}
					}


					break;

				case "/deleteLeave":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							leaveDao.deleteLeave(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("leaveManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/contractManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							session.setAttribute("listContract", contractDao.getAll());
							request.getRequestDispatcher("page/listContract.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/addContract":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							Contract contract = new Contract();
							contract.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							contract.setStartDate(LocalDate.parse(request.getParameter("startDate")));
							contract.setEndDate(LocalDate.parse(request.getParameter("endDate")));
							contract.setContractType(request.getParameter("contractType"));
							contract.setNote(request.getParameter("note"));

							contractDao.add(contract);
							response.sendRedirect("contractManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/editContract":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int contractId = Integer.parseInt(request.getParameter("id"));
							Contract contract = contractDao.getById(contractId);
							contract.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							contract.setStartDate(LocalDate.parse(request.getParameter("startDate")));
							contract.setEndDate(LocalDate.parse(request.getParameter("endDate")));
							contract.setContractType(request.getParameter("contractType"));
							contract.setNote(request.getParameter("note"));

							contractDao.update(contract);
							response.sendRedirect("contractManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/deleteContract":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							contractDao.delete(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("contractManager");
						} else {
							forbidden(request, response);
						}
					}
					break;

				case "/rewardManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							session.setAttribute("listRewardsDiscipline", rewardDisciplineDao.getAll());
							request.getRequestDispatcher("page/listRewardsDiscipline.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}

					}

					break;

				case "/addRewardDiscipline":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {

							RewardsDiscipline rewardDiscipline = new RewardsDiscipline();
							rewardDiscipline.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							rewardDiscipline
									.setDateRecorded(LocalDate.parse(request.getParameter("dateRecored")));
							rewardDiscipline.setTitle(request.getParameter("title"));
							rewardDiscipline.setDescription(request.getParameter("description"));
							rewardDiscipline.setType(request.getParameter("type"));

							rewardDisciplineDao.addRewardsDiscipline(rewardDiscipline);
							response.sendRedirect("rewardManager");
						} else {
							forbidden(request, response);
						}

					}

					break;

				case "/editRewardDiscipline":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int rewardId = Integer.parseInt(request.getParameter("id"));
							RewardsDiscipline rewardDiscipline = rewardDisciplineDao.getById(rewardId);

							rewardDiscipline.setEmployeeId(Integer.parseInt(request.getParameter("employeeId")));
							rewardDiscipline
									.setDateRecorded(LocalDate.parse(request.getParameter("dateRecored")));
							rewardDiscipline.setTitle(request.getParameter("title"));
							rewardDiscipline.setDescription(request.getParameter("description"));
							rewardDiscipline.setType(request.getParameter("type"));

							rewardDisciplineDao.updateRewardsDiscipline(rewardDiscipline);
							response.sendRedirect("rewardManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/deleteRewardDiscipline":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							rewardDisciplineDao.deleteRewardsDiscipline((Integer.parseInt(request.getParameter("id"))));
							response.sendRedirect("rewardManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				// ________________________ Khu vực user
				case "/userManager":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							session.setAttribute("listUser", userDao.getAllUsers());
							request.getRequestDispatcher("page/listUser.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/addUser":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {

							String username = request.getParameter("username");
							String password = request.getParameter("password");
							String role = request.getParameter("role");

							System.out.println("Username: " + username);
							System.out.println("Password: " + password);
							System.out.println("Role: " + role);

							User newUser = new User();
							newUser.setUsername(username);
							newUser.setPassword(password);
							newUser.setRole(role);
							userDao.addUser(newUser);

							response.sendRedirect("userManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/editUser":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							int userId = Integer.parseInt(request.getParameter("id"));
							String username = request.getParameter("username");
							String password = request.getParameter("password");
							String role = request.getParameter("role");

							User user = userDao.getUserById(userId);

							user.setUsername(username);
							user.setPassword(password);
							user.setRole(role);

							userDao.updateUser(user);
							response.sendRedirect("userManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/deleteUser":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {
							userDao.deleteUser(Integer.parseInt(request.getParameter("id")));
							response.sendRedirect("userManager");
						} else {
							forbidden(request, response);
						}
					}

					break;

				// ________________________

				case "/viewReport":
					if (userDao.getLoginStatus()) {
						user = (User) session.getAttribute("user");
						if (checkRole(user, "admin", "hr")) {

							request.getRequestDispatcher("page/viewReport.jsp").forward(request, response);
						} else {
							forbidden(request, response);
						}
					}

					break;

				case "/logout":
					if (userDao.getLoginStatus()) {
						userDao.setLoginStatus(false);
						user = null;
						session.setAttribute("isLogout", true);
						session.setAttribute("isFailed", true);
						response.sendRedirect("login");
					}else {
						response.sendRedirect("login");
					}
					break;

				default:

					if (!userDao.getLoginStatus()) {
						response.sendRedirect("login");
					} else {
						response.sendRedirect("main");
					}

					break;
			}

		} catch (Exception ex) {
			throw new ServletException(ex);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private boolean checkRole(User user, String... roles) {
		if (user == null) {
			return false;
		}
		String userRole = user.getRole();
		for (String r : roles) {
			if (r.equalsIgnoreCase(userRole)) {
				return true;
			}
		}
		return false;
	}

	private void forbidden(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		request.setAttribute("message", "Bạn không có quyền truy cập trang này.");
		request.getRequestDispatcher("forbidden.jsp").forward(request, response);
	}

}
