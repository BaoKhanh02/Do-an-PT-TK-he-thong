-- 1. BẢNG CHÍNH

CREATE TABLE GiaoVien (
    GiaoVienID INT PRIMARY KEY,
    TenGiaoVien NVARCHAR(100) NOT NULL,
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    TenDangNhap NVARCHAR(50) UNIQUE,
    MatKhau NVARCHAR(100),
    TrangThai BIT DEFAULT 1
);

CREATE TABLE LopHoc (
    LopHocID INT PRIMARY KEY,
    TenLop NVARCHAR(50),
    NamHoc NVARCHAR(20),
    GiaoVienChuNhiemID INT NULL,
    FOREIGN KEY (GiaoVienChuNhiemID) REFERENCES GiaoVien(GiaoVienID)
);

CREATE TABLE MonHoc (
    MonHocID INT PRIMARY KEY,
    TenMonHoc NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE PhanCongGiangDay (
    PhanCongID INT PRIMARY KEY IDENTITY(1,1),
    GiaoVienID INT,
    LopHocID INT,
    MonHocID INT,
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID),
    FOREIGN KEY (LopHocID) REFERENCES LopHoc(LopHocID),
    FOREIGN KEY (MonHocID) REFERENCES MonHoc(MonHocID)
);

CREATE TABLE PhuHuynh (
    PhuHuynhID INT PRIMARY KEY,
    TenPhuHuynh NVARCHAR(100),
    SoDienThoai NVARCHAR(20),
    Email NVARCHAR(100),
    TenDangNhap NVARCHAR(50) UNIQUE,
    MatKhau NVARCHAR(100),
    TrangThai BIT DEFAULT 1
);

CREATE TABLE HocSinh (
    HocSinhID INT PRIMARY KEY,
    TenHocSinh NVARCHAR(100),
    NgaySinh DATE CHECK (NgaySinh < GETDATE()),
    GioiTinh NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ')),
    DiaChi NVARCHAR(255),
    LopHocID INT,
    PhuHuynhID INT,
    FOREIGN KEY (LopHocID) REFERENCES LopHoc(LopHocID),
    FOREIGN KEY (PhuHuynhID) REFERENCES PhuHuynh(PhuHuynhID)
);

CREATE TABLE Diem (
    DiemID INT PRIMARY KEY,
    HocSinhID INT,
    MonHocID INT,
    LopHocID INT,
    GiaoVienID INT,
    DiemHK1 FLOAT CHECK (DiemHK1 BETWEEN 0 AND 10),
    DiemHK2 FLOAT CHECK (DiemHK2 BETWEEN 0 AND 10),
    DanhGiaCuoiNam NVARCHAR(100),
    GhiChu NVARCHAR(MAX),
    NgayNhap DATE,
    FOREIGN KEY (HocSinhID) REFERENCES HocSinh(HocSinhID),
    FOREIGN KEY (MonHocID) REFERENCES MonHoc(MonHocID),
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID),
    FOREIGN KEY (LopHocID) REFERENCES LopHoc(LopHocID)
);

CREATE TABLE HanhKiem (
    HanhKiemID INT PRIMARY KEY,
    HocSinhID INT,
    LopHocID INT,
    GiaoVienID INT,
    XepLoai NVARCHAR(20),
    NhanXet NVARCHAR(MAX),
    NgayNhap DATE,
    FOREIGN KEY (HocSinhID) REFERENCES HocSinh(HocSinhID),
    FOREIGN KEY (LopHocID) REFERENCES LopHoc(LopHocID),
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID)
);

CREATE TABLE LogHanhKiem (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    HocSinhID INT,
    XepLoaiCu NVARCHAR(20),
    XepLoaiMoi NVARCHAR(20),
    ThoiGianThayDoi DATETIME,
    FOREIGN KEY (HocSinhID) REFERENCES HocSinh(HocSinhID)
);

CREATE TABLE HocPhi (
    HocPhiID INT PRIMARY KEY,
    HocSinhID INT,
    SoTien FLOAT,
    DaNop BIT,
    HanDong DATE,
    FOREIGN KEY (HocSinhID) REFERENCES HocSinh(HocSinhID)
);

CREATE TABLE PhanHoi (
    PhanHoiID INT PRIMARY KEY,
    DoiTuongGui NVARCHAR(20) CHECK (DoiTuongGui IN ('PhuHuynh', 'GiaoVien')),
    NoiDung NVARCHAR(MAX),
    NgayGui DATE,
    GiaoVienID INT NULL,
    PhuHuynhID INT NULL,
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID),
    FOREIGN KEY (PhuHuynhID) REFERENCES PhuHuynh(PhuHuynhID)
);

CREATE TABLE PhanHoiTraLoi (
    TraLoiID INT PRIMARY KEY IDENTITY(1,1),
    PhanHoiID INT,
    GiaoVienID INT,
    NoiDungTraLoi NVARCHAR(MAX),
    NgayTraLoi DATE DEFAULT GETDATE(),
    FOREIGN KEY (PhanHoiID) REFERENCES PhanHoi(PhanHoiID),
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID)
);

CREATE TABLE CanhBao (
    CanhBaoID INT PRIMARY KEY IDENTITY(1,1),
    NoiDung NVARCHAR(MAX),
    HocSinhID INT,
    DiemTrungBinh FLOAT,
    GioiTinh NVARCHAR(10),
    ThoiGianCanhBao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (HocSinhID) REFERENCES HocSinh(HocSinhID)
);

CREATE TABLE ThongBao (
    ThongBaoID INT PRIMARY KEY,
    GiaoVienID INT,
    LopHocID INT,
    TieuDe NVARCHAR(100),
    NoiDung NVARCHAR(MAX),
    NgayGui DATE,
    FOREIGN KEY (GiaoVienID) REFERENCES GiaoVien(GiaoVienID),
    FOREIGN KEY (LopHocID) REFERENCES LopHoc(LopHocID)
);

-- 2. TRIGGER

-- Trigger cảnh báo học lực yếu
CREATE TRIGGER trg_CanhBaoDiemCaNamThap
ON Diem
AFTER INSERT, UPDATE
AS
BEGIN
    INSERT INTO CanhBao (NoiDung, HocSinhID, DiemTrungBinh, GioiTinh)
    SELECT 
        N'Học sinh ' + HS.TenHocSinh + N' (' + HS.GioiTinh + N') có điểm trung bình thấp: ' + 
        CAST(((I.DiemHK1 + I.DiemHK2)/2) AS NVARCHAR(10)),
        I.HocSinhID,
        ((I.DiemHK1 + I.DiemHK2)/2),
        HS.GioiTinh
    FROM inserted I
    JOIN HocSinh HS ON I.HocSinhID = HS.HocSinhID
    WHERE ((I.DiemHK1 + I.DiemHK2)/2) < 5;
END;

-- Trigger kiểm tra điểm nhập sai
CREATE TRIGGER trg_KiemTraDiemSai
ON Diem
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted 
        WHERE DiemHK1 NOT BETWEEN 0 AND 10 OR DiemHK2 NOT BETWEEN 0 AND 10
    )
    BEGIN
        RAISERROR(N'Điểm học kỳ phải nằm trong khoảng từ 0 đến 10.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Diem (DiemID, HocSinhID, MonHocID, GiaoVienID, LopHocID, DiemHK1, DiemHK2, DanhGiaCuoiNam, GhiChu, NgayNhap)
        SELECT DiemID, HocSinhID, MonHocID, GiaoVienID, LopHocID, DiemHK1, DiemHK2, DanhGiaCuoiNam, GhiChu, NgayNhap
        FROM inserted;
    END
END;

-- Trigger log hạnh kiểm 
CREATE TRIGGER trg_LogHanhKiem
ON HanhKiem
FOR UPDATE
AS
BEGIN
    INSERT INTO LogHanhKiem(HocSinhID, XepLoaiCu, XepLoaiMoi, ThoiGianThayDoi)
    SELECT d.HocSinhID, d.XepLoai, i.XepLoai, GETDATE()
    FROM deleted d
    JOIN inserted i ON d.HanhKiemID = i.HanhKiemID
    WHERE d.XepLoai <> i.XepLoai;
END;

-- 3. STORED PROCEDURE

-- Stored procedure thống kê điểm
CREATE PROCEDURE ThongKeDiemTheoLop
    @HocKyID INT
AS
BEGIN
    SELECT 
        LH.TenLop,
        MH.TenMonHoc,
        AVG((D.DiemHK1 + D.DiemHK2)/2) AS DiemTrungBinhCaNam
    FROM Diem D
    JOIN LopHoc LH ON D.LopHocID = LH.LopHocID
    JOIN MonHoc MH ON D.MonHocID = MH.MonHocID
    GROUP BY LH.TenLop, MH.TenMonHoc
    ORDER BY LH.TenLop, MH.TenMonHoc;
END;

-- Stored procedure danh sách học lực yếu
CREATE PROCEDURE DanhSachHocLucYeu
    @LopHocID INT
AS
BEGIN
    SELECT 
        HS.TenHocSinh,
        MH.TenMonHoc,
        ((D.DiemHK1 + D.DiemHK2)/2) AS DiemTrungBinh
    FROM Diem D
    JOIN HocSinh HS ON D.HocSinhID = HS.HocSinhID
    JOIN MonHoc MH ON D.MonHocID = MH.MonHocID
    WHERE D.LopHocID = @LopHocID
      AND ((D.DiemHK1 + D.DiemHK2)/2) < 5
    ORDER BY HS.TenHocSinh;
END;
