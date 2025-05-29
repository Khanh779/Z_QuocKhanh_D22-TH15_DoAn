# Java Web - Quản Lý Nhân Viên

Dự án Java Web động giúp quản lý thông tin nhân viên, được phát triển bằng **JSP/Servlet**, chạy trên **Apache Tomcat**, và sử dụng **MySQL** làm cơ sở dữ liệu.

---

## Tính năng chính

- Thêm, sửa, xoá nhân viên
- Tìm kiếm, lọc theo tên, giới tính, phòng ban
- Quản lý thông tin chi tiết (lương, chức vụ, ngày vào làm)
- Giao diện người dùng đơn giản với JSP

---

## Công nghệ sử dụng

| Thành phần       | Công nghệ                 |
|------------------|---------------------------|
| Backend          | Java Servlet, JSP         |
| Frontend         | HTML, CSS, JSP            |
| Server           | Apache Tomcat (8.x hoặc 9.x) |
| Cơ sở dữ liệu    | MySQL                     |
| IDE              | Eclipse hoặc IntelliJ     |

---

## Cấu trúc thư mục

EmployeeManager/
├── src/
│ └── controller/ # Servlet xử lý logic
│ └── model/ # Các lớp Java (Employee, DAO, DBContext)
├── WebContent/
│ └── index.jsp
│ └── employee.jsp
│ └── css/
├── WEB-INF/
│ └── web.xml
└── README.md