# Đồ án Phân tích & Thiết kế hệ thống - K225480106028 - Vũ Bảo Khánh

## QUẢN LÝ SỔ LIÊN LẠC ĐIỆN TỬ

## DÀN Ý

### 1. Phạm vi

  Sổ liên lạc điện tử có thể được sử dụng ở cả trường THCS và THPT. Nó được tạo ra để tạo mối quan hệ chặt chẽ giữa nhà trường và gia đình, giúp nhà trường quản lí được học sinh và thông báo đến gia đình sớm nhất có thể.

### 2. Đối tượng

#### a) Quản trị viên

- Quản lý tài khoản giáo viên, phụ huynh.
- Phân quyền sử dụng hệ thống.
- Quản lý cơ sở dữ hệ thống.

#### b) Giáo viên

- Cập nhật điểm số, nhận xét học tập của giáo viên đối với sinh viên.
- Gửi thời khóa biểu hàng tuần.
- Gửi thông báo và nhận phản hồi từ phụ huynh.
- Quản lý chuyên cần (Diểm danh, nghỉ học).

#### c) Phụ huynh

- Xem điểm số và nhận xét của giáo viên.
- Nhận thông báo từ nhà trường.
- Gửi phản hồi, trao đổi với giáo viên.

### 3. Chức năng

#### a) Chức năng quản lý tài khoản Admin

- Tạo, sửa, xóa tài khoản giáo viên, phụ huynh, học sinh.
- Phân quyền sử dụng hệ thống.

#### b) Chức năng quản lý thông tin học sinh (Giáo viên/Admin)

- Cập nhật danh sách lớp học.
- Quản lý thông tin cá nhân học sinh (họ tên, ngày sinh, lớp...).
- Theo dõi quá trình học tập và rèn luyện của học sinh.

#### c) Chức năng quản lý điểm số & nhận xét (Giáo viên)

- Nhập điểm kiểm tra, điểm thi.
- Nhận xét học lực, hạnh kiểm của học sinh.
- Cập nhật và chỉnh sửa điểm nếu cần.

#### d) Chức năng quản lý chuyên cần (Giáo viên)

- Điểm danh học sinh theo buổi học.
- Ghi nhận số ngày nghỉ phép, nghỉ không phép.

#### e) Chức năng liên lạc giữa nhà trường - phụ huynh (Giáo viên - Phụ huynh)

- Gửi thông báo về tình hình học tập, hoạt động của lớp.
- Trao đổi giữa giáo viên và phụ huynh.
- Gửi thư mời họp phụ huynh.

#### f) Chức năng xem thông tin sổ liên lạc điện tử (Phụ huynh)

- Xem điểm số, nhận xét của giáo viên.
- Xem lịch học, lịch thi.
- Xem thông báo của trường và giáo viên.

#### Chức năng báo cáo và thống kê (Admin/Giáo viên)

- Xuất báo cáo tổng hợp kết quả học tập theo lớp, theo học kỳ.
- Thống kê học sinh có điểm dưới trung bình.
- Thống kê số ngày nghỉ học của học sinh.
