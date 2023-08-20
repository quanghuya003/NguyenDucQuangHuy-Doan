use master
go
IF DB_ID('LibraryManagement') IS NOT NULL
	DROP DATABASE LibraryManagement
GO
CREATE DATABASE LibraryManagement
GO
USE LibraryManagement
GO

CREATE TABLE NGUOIDUNG
(
	TenDangNhap CHAR(255) PRIMARY KEY,
	TenHienThi NVARCHAR(255) NOT NULL,
	MatKhau CHAR(1000) NOT NULL,
	Loai INT --0:nhân viên || 1: admin || 2: quản lí
)

CREATE TABLE NHANVIEN
(
	MaNV NVARCHAR(10) NOT NULL PRIMARY KEY,
	TenNV NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(100) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	NgaySinh DATE NOT NULL,
	SDT VARCHAR(10) NOT NULL,
	Email NVARCHAR(100) NOT NULL
)

CREATE TABLE DOCGIA
(
	MaDG NVARCHAR(10) NOT NULL PRIMARY KEY,
	TenDG NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(100) NOT NULL,
	NgaySinh DATETIME NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	SDT VARCHAR(10) NOT NULL,
	Email NVARCHAR(100) NOT NULL
)

CREATE TABLE LOAISACH(
	MaLoaiSach NVARCHAR(5) PRIMARY KEY,
	TenLoaiSach NVARCHAR(50) not null,
)

CREATE TABLE SACH
(
	MaSach NVARCHAR(10) NOT NULL PRIMARY KEY,
	TenSach NVARCHAR(50) NOT NULL,
	TacGia NVARCHAR(30) NOT NULL,
	MaLoaiSach NVARCHAR(5) NOT NULL,
	NhaXuatBan NVARCHAR(50) NOT NULL,
	Anh image,
	GiaSach FLOAT NOT NULL,
	SoLuong INT NOT NULL,
	TinhTrang NVARCHAR(10)

	CONSTRAINT FK_SACH_LOAISACH FOREIGN KEY(MaLoaiSach) REFERENCES LOAISACH(MaLoaiSach)
)

CREATE TABLE PHIEUMUON
(
	IDPhieuMuon INT IDENTITY (1,1) PRIMARY KEY,
	MaPhieuMuon AS 'PM' + RIGHT('00000'+ CAST(IDPhieuMuon AS varchar),6),
	MaDG NVARCHAR(10) NOT NULL,
	MaSach NVARCHAR(10) NOT NULL,
	NgayMuon DATETIME NOT NULL,
	NgayTra DATETIME NOT NULL

	CONSTRAINT FK_PHIEUMUON_DOCGIA FOREIGN KEY(MaDG) REFERENCES DOCGIA(MaDG),
	CONSTRAINT FK_PHIEUMUON_SACH FOREIGN KEY(MaSach) REFERENCES SACH(MaSach)
)

CREATE TABLE PHIEUTRA
(
	IDPhieuTra INT IDENTITY (1,1) PRIMARY KEY,
	MaPhieuTra AS 'PT' + RIGHT('00000'+ CAST(IDPhieuTra AS varchar),6),
	MaDG NVARCHAR(10) NOT NULL,
	MaSach NVARCHAR(10) NOT NULL,
	NgayTra DATETIME NOT NULL

	CONSTRAINT FK_PHIEUTRA_DOCGIA FOREIGN KEY(MaDG) REFERENCES DOCGIA(MaDG),
	CONSTRAINT FK_PHIEUTRA_SACH FOREIGN KEY(MaSach) REFERENCES SACH(MaSach)
)

INSERT INTO NGUOIDUNG VALUES('admin', N'Admin', '202cb962ac59075b964b07152d234b70',  1); --Mật khẩu: 123
INSERT INTO NGUOIDUNG VALUES('buitungkien', N'Bùi Tùng Kiên', '202cb962ac59075b964b07152d234b70',  2); --Mật khẩu: 123
INSERT INTO NGUOIDUNG VALUES('nguyenvana', N'Nguyễn Văn A', '202cb962ac59075b964b07152d234b70',  0); --Mật khẩu: 123

INSERT INTO NHANVIEN(MaNV, TenNV, GioiTinh, DiaChi, NgaySinh, SDT, Email) VALUES	
('NV001', N'Bành Thị Bưởi', N'Nam', N'An Giang', '8/13/2002', '0868459227', 'thibuoi@gmail.com'),
('NV002', N'Nguyễn Văn A', N'Nam', N'An Giang', '4/21/2002', '0932894322', 'vana@gmail.com'),
('NV003', N'Trần Thị B', N'Nữ', N'An Giang', '12/14/2002', '0846736334', 'thib@gmail.com'),
('NV004', N'Nguyễn Thị C', N'Nữ', N'An Giang', '03/09/2002', '0876723423', 'thic@gmail.com')

INSERT INTO DOCGIA(MaDG, TenDG, GioiTinh, NgaySinh, DiaChi, SDT, Email) VALUES	
('DG001', N'Trần Hà Linh', N'Nữ', '8/22/1998', N'Long Xuyên', '0957345321', 'tranhalinh@gmail.com'),
('DG002', N'Đỗ Thị Trâm Anh', N'Nữ', '3/29/1998', N'Cần Thơ', '0876376232', 'dothitramanh@gmail.com'),
('DG003', N'Phan Minh Đạt', N'Nam', '9/17/1998', N'Châu Đốc', '0947383662', 'phanminhdat@gmail.com'),
('DG004', N'Lê Thị Khánh Huyền', N'Nữ', '1/15/1998', N'Châu Phú', '0887857333', 'lethikhanhhuyen@gmail.com'),
('DG005', N'Trần Thị Ngọc Trinh', N'Nữ', '7/30/1998', N'Châu Thành', '0978973433', 'tranthingoctrinh@gmail.com')

INSERT INTO LOAISACH(MaLoaiSach, TenLoaiSach) VALUES
('L001', N'Triết Học'),
('L002', N'Lập Trình'),
('L003', N'Toán Học'),
('L004', N'Tiếng Anh')

INSERT INTO SACH VALUES ('S001', N'Lập trình hướng đối tượng', N'Không biết', 'L002', 'AGU', '1', 15000, 13, N'Còn')
INSERT INTO SACH VALUES ('S002', N'Tư tưởng Hồ Chí Minh', N'Không biết', 'L001', 'AGU', '1', 15000, 10, N'Còn')
INSERT INTO SACH VALUES ('S003', N'Toán A3', N'Không biết', 'L003', 'AGU', '1', 30000, 15, N'Còn')
INSERT INTO SACH VALUES ('S004', N'Lập trình quản lý', N'Không biết', 'L002', 'AGU', '1', 40000, 13, N'Còn')

INSERT INTO PHIEUMUON VALUES ('DG001','S002','5/20/2023', '5/24/2023')
INSERT INTO PHIEUMUON values ('DG003','S001','5/21/2023', '5/23/2023')
INSERT INTO PHIEUMUON values ('DG004','S001','5/20/2023', '5/23/2023')
INSERT INTO PHIEUMUON values ('DG004','S004','5/20/2023', '5/31/2023')

INSERT INTO PHIEUTRA VALUES ('DG004','S003','5/22/2023')
INSERT INTO PHIEUTRA VALUES ('DG002','S004','5/24/2023')
INSERT INTO PHIEUTRA VALUES ('DG005','S004','4/23/2023')
INSERT INTO PHIEUTRA VALUES ('DG003','S002','5/31/2023')

select * from PHIEUMUON

SELECT pm.IDPhieuMuon, pm.MaPhieuMuon, pm.MaDG, dg.TenDG, pm.MaSach, s.TenSach, pm.NgayMuon, pm.NgayTra FROM DOCGIA dg, SACH s, PHIEUMUON pm WHERE pm.MaSach = s.MaSach AND pm.MaDG = dg.MaDG AND NgayTra < GETDATE()



SELECT pm.IDPhieuMuon, pm.MaPhieuMuon, pm.MaDG, dg.TenDG, pm.MaSach, s.TenSach, pm.NgayMuon, pm.NgayTra FROM DOCGIA dg, SACH s, PHIEUMUON pm WHERE pm.MaSach = s.MaSach AND pm.MaDG = dg.MaDG AND MONTH(pm.NgayMuon) = 1
