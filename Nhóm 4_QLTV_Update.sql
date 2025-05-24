IF EXISTS (SELECT * FROM sys.databases WHERE name = 'LibraryDB')
    DROP DATABASE LibraryDB;
GO

-- Tạo cơ sở dữ liệu mới
CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO


-- Tạo bảng DOCGIA
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.DOCGIA') AND sysstat & 0xf = 3)
    DROP TABLE dbo.DOCGIA;
GO
CREATE TABLE dbo.DOCGIA (
    MADG INT PRIMARY KEY,
    HOTEN NVARCHAR(100),
    NGAYSINH DATE,
    DIACHI NVARCHAR(200),
    NGHENGHIEP NVARCHAR(100)
);
GO

-- Tạo bảng SACH
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SACH') AND sysstat & 0xf = 3)
    DROP TABLE dbo.SACH;
GO
CREATE TABLE dbo.SACH (
    MASH INT PRIMARY KEY,
    TENSACH NVARCHAR(200),
    TACGIA NVARCHAR(100),
    NHAXB NVARCHAR(100),
    NAMXB INT
);
GO

-- Tạo bảng PHIEUMUON
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.PHIEUMUON') AND sysstat & 0xf = 3)
    DROP TABLE dbo.PHIEUMUON;
GO
CREATE TABLE dbo.PHIEUMUON (
    SOPM INT PRIMARY KEY,
    NGAYMUON DATE,
    MADG INT,
    CONSTRAINT FK_DOCGIA FOREIGN KEY (MADG) REFERENCES dbo.DOCGIA(MADG)
);
GO

-- Kiểm tra và xóa nếu bảng đã tồn tại
IF OBJECT_ID('dbo.CT_PHIEUMUON', 'U') IS NOT NULL
    DROP TABLE dbo.CT_PHIEUMUON;
GO

-- Tạo bảng chi tiết phiếu mượn
CREATE TABLE dbo.CT_PHIEUMUON (
    SOPM INT,          -- Số phiếu mượn
    MASH INT,          -- Mã sách
    NGAYTRA DATE,       -- Ngày trả
	SOLANMUON INT,      -- Số lần mượn 
    GHICHU NVARCHAR(200) NULL, -- Ghi chú nếu có
    PRIMARY KEY (SOPM, MASH),   -- Khóa chính kết hợp
    FOREIGN KEY (SOPM) REFERENCES dbo.PHIEUMUON(SOPM) ON DELETE CASCADE,
    FOREIGN KEY (MASH) REFERENCES dbo.SACH(MASH) ON DELETE CASCADE
);
GO

-- Nhập dữ liệu vào bảng DOCGIA
INSERT INTO dbo.DOCGIA (MADG, HOTEN, NGAYSINH, DIACHI, NGHENGHIEP) VALUES
(1, N'Nguyễn Văn Anh', '1990-05-01', N'Hà Nội', N'Giảng viên'),
(2, N'Nguyễn Thị Bình', '1992-07-15', N'Đà Nẵng', N'Kỹ sư'),
(3, N'Nguyễn Minh Cường', '1985-03-22', N'Ho Chi Minh', N'Bác sĩ'),
(4, N'Hoàng Minh Đức', '1980-10-10', N'Bắc Ninh', N'Giám đốc'),
(5, N'Lê Thanh Thản', '1995-04-05', N'Vũng Tàu', N'Marketing'),
(6, N'Phạm Văn Phúc', '1988-12-12', N'Cần Thơ', N'Tiếp thị'),
(7, N'Ngô Hồng Gia Nghi', '1993-02-25', N'Bình Dương', N'Thợ xây'),
(8, N'Trần Mai Hân', '1990-11-20', N'Đắk Lắk', N'Nhân viên ngân hàng'),
(9, N'Vũ Đức Linh', '1997-08-18', N'Vĩnh Long', N'Kinh doanh tự do');
GO

-- Nhập dữ liệu vào bảng SACH
INSERT INTO dbo.SACH (MASH, TENSACH, TACGIA, NHAXB, NAMXB) VALUES
(1, N'Tin học cơ bản', N'Nguyễn Văn Xuân', N'NXB Đại học', 2020),
(2, N'Kỹ năng sống', N'Nguyễn Thị Yến', N'NXB Giáo dục', 2019),
(3, N'Chữa bệnh hiệu quả', N'Nguyễn Minh Khánh', N'NXB Y học', 2021),
(4, N'Lập trình C++ cơ bản', N'Trần Quốc Ân', N'NXB Khoa học', 2018),
(5, N'Marketing căn bản', N'Nguyễn Minh Bảo', N'NXB Tài chính', 2020),
(6, N'Văn học hiện đại', N'Phan Thị Chung', N'NXB Văn học', 2022),
(7, N'Triết học cho người mới bắt đầu', N'Hoàng Thiên Dung', N'NXB Triết học', 2021),
(8, N'Những bài học cuộc sống', N'Nguyễn Hồng Hân', N'NXB Hội Nhà văn', 2019),
(9, N'Giải pháp sáng tạo trong công việc', N'Đỗ Minh Phúc Qúy', N'NXB Doanh nghiệp', 2023);
GO

-- Nhập dữ liệu vào bảng PHIEUMUON
INSERT INTO dbo.PHIEUMUON (SOPM, NGAYMUON, MADG) VALUES
(1, '2023-10-15', 1),
(2, '2023-10-17', 2),
(3, '2023-10-20', 3),
(4, '2023-11-05', 4),
(5, '2023-11-07', 5),
(6, '2023-11-10', 6),
(7, '2023-11-12', 7),
(8, '2023-11-15', 8),
(9, '2023-11-17', 9);
GO
-- Nhập dữ liệu vào bảng CT_PHIEUMUON (Chi tiết phiếu mượn)
INSERT INTO dbo.CT_PHIEUMUON (SOPM, MASH, NGAYTRA, GHICHU,SOLANMUON) VALUES
(1, 1, '2023-11-15', N'Mượn lần đầu','1'),        -- Nguyễn Văn Anh mượn sách 1
(2, 2, '2023-11-17', N'Mượn thêm lần 2','1'),     -- Nguyễn Thị Bình mượn sách 2
(3, 3, '2023-11-20', N'Mượn cho nghiên cứu','3'),-- Nguyễn Minh Cường mượn sách 3
(4, 4, '2023-12-05', N'Thêm cho công việc','1'), -- Hoàng Minh Đức mượn sách 4
(5, 5, '2023-12-07', N'Mượn tham khảo','5'),     -- Lê Thanh Thản mượn sách 5
(6, 6, '2023-12-10', N'Mượn học tập','1'),        -- Phạm Văn Phúc mượn sách 6
(7, 7, '2023-12-12', N'Mượn đọc thêm','4'),       -- Ngô Hồng Gia Nghi mượn sách 7
(8, 8, '2023-12-15', N'Mượn giải trí','1'),       -- Trần Mai Hân mượn sách 8
(9, 9, '2023-12-17', N'Mượn mở rộng kiến thức','2'); -- Vũ Đức Linh mượn sách 9
GO

DROP TABLE CT_PHIEUMUON

-- 12 CÂU TRUY VẤN(PHẦN A)
--2 CÂU TRUY VẤN LỒNG 
-- Phần Câu hỏi truy vấn tự đặt tự trả lời 
-- Câu 1: Tìm độc giả đã mượn cuốn sách có tên là "Văn học hiện đại"?
SELECT D.HOTEN, S.TENSACH
FROM DOCGIA D
JOIN PHIEUMUON P ON D.MADG = P.MADG
JOIN CT_PHIEUMUON CT ON P.SOPM = CT.SOPM
JOIN SACH S ON S.MASH = CT.MASH
WHERE CT.MASH = 6;

-- Câu 2: Tìm độc giả đã mượn sách có ngày trả sau 2023-12-01
SELECT D.HOTEN, D.MADG, CT.NGAYTRA
FROM dbo.DOCGIA D
JOIN dbo.PHIEUMUON PM ON D.MADG = PM.MADG
JOIN dbo.CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
WHERE CT.NGAYTRA > '2023-12-01';


-- 2 CÂU SUBQUERY
-- Câu 3: Liệt kê tên độc giả đã mượn sách của NXB 'NXB Y học' SELECT S.TENSACH, D.HOTEN
SELECT D.HOTEN, S.NHAXB
FROM DOCGIA D
JOIN PHIEUMUON PM ON D.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN SACH S ON CT.MASH = S.MASH
WHERE S.NHAXB = N'NXB Y học';


-- Câu 4: Liệt kê tên độc giả đã mượn sách sau ngày 2023-11-01
SELECT D.HOTEN,PM.NGAYMUON
FROM DOCGIA D
JOIN PHIEUMUON PM ON D.MADG = PM.MADG
WHERE PM.NGAYMUON > '2023-11-01';

-- 2 câu hỏi truy vấn bất kỳ  
-- Câu 5: Tìm tên các sách mà độc giả có tên là "Nguyễn Văn Anh" đã mượn.
SELECT S.TENSACH AS TenSach, D.HOTEN
FROM dbo.PHIEUMUON P
JOIN dbo.CT_PHIEUMUON CT ON P.SOPM = CT.SOPM
JOIN dbo.SACH S ON CT.MASH = S.MASH
JOIN dbo.DOCGIA D ON P.MADG = D.MADG
WHERE D.HOTEN = N'Nguyễn Văn Anh';

-- Câu 6: Sử dụng câu lệnh HAVING để lọc ra những bản ghi có số lần mượn (SOLANMUON) lớn hơn 1 mà không sử dụng SUM hoặc COUNT.
SELECT CT.MASH, CT.SOPM, CT.SOLANMUON
FROM dbo.CT_PHIEUMUON CT
GROUP BY CT.MASH, CT.SOPM, CT.SOLANMUON
HAVING CT.SOLANMUON > 1;


-- 2 CÂU UPDATE
-- Câu 7: Cập nhật địa chỉ mới cho độc giả có tên là "Nguyễn Văn Anh" thành: "123 Đường ABC, Quận 1, TP.HCM"
UPDATE dbo.DOCGIA
SET DIACHI = N'123 Đường ABC, Quận 1, TP.HCM'
WHERE HOTEN = N'Nguyễn Văn Anh';

-- Câu 8: Cập nhật năm xuất bản của quyển sách "Lập trình C++ cơ bản" thành 2022
UPDATE dbo.SACH
SET NAMXB = 2022
WHERE TENSACH = N'Lập trình C++ cơ bản';
-- 2 CÂU DELETE 

-- Câu 9: Xóa thông tin của độc giả tên "Vũ Đức Linh".
DELETE FROM dbo.DOCGIA
WHERE HOTEN = N'Vũ Đức Linh';
-- Câu 10: Xóa các cuốn sách được xuất bản năm 2019.
DELETE FROM dbo.SACH
WHERE NAMXB = 2019;

-- 2 CÂU GROUP BY 
---Câu 11: Thống kê số lượng phiếu mượn theo từng độc giả
SELECT D.HOTEN, COUNT(P.SOPM) AS SoLuongPhieuMuon
FROM DOCGIA D
JOIN PHIEUMUON P ON D.MADG = P.MADG
GROUP BY D.HOTEN;


-- Câu 12: Lấy danh sách các tên sách đã mượn 
SELECT S.TENSACH
FROM SACH S
JOIN CT_PHIEUMUON C ON S.MASH = C.MASH
GROUP BY S.TENSACH;


--BÀI CÁ NHÂN
--Võ Minh Cường - 23696691
--1 Liệt kê tên sách và năm xuất bản của tất cả các sách xuất bản từ năm 2020 trở đi.
SELECT TENSACH, NAMXB
FROM SACH
WHERE NAMXB >= 2020;

--2 Hiển thị tên độc giả và số phiếu mượn của họ (nếu có).
SELECT DG.HOTEN, PM.SOPM
FROM DOCGIA DG
LEFT JOIN PHIEUMUON PM ON DG.MADG = PM.MADG;

--3 Liệt kê tất cả các phiếu mượn có chứa sách do "Nguyễn Minh Bảo" viết.
SELECT DISTINCT PM.SOPM, DG.HOTEN, S.TENSACH
FROM PHIEUMUON PM
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN SACH S ON CT.MASH = S.MASH
JOIN DOCGIA DG ON PM.MADG = DG.MADG
WHERE S.TACGIA = N'Nguyễn Minh Bảo';

--4.Tìm tên sách mà bạn đọc có nghề nghiệp là 'Giám đốc' đã mượn.
SELECT S.TENSACH
FROM SACH S
JOIN CT_PHIEUMUON CT ON S.MASH = CT.MASH
JOIN PHIEUMUON PM ON CT.SOPM = PM.SOPM
JOIN DOCGIA D ON PM.MADG = D.MADG
WHERE D.NGHENGHIEP = N'Giám đốc';


--Nguyễn Đức Huy - 23730841
--1  Liệt kê các sách có tên chứa từ “cơ bản”.
SELECT TENSACH, TACGIA
FROM SACH
WHERE TENSACH LIKE N'%cơ bản%';

--2  Hiển thị danh sách độc giả và số sách họ đã mượn.
SELECT DG.HOTEN, COUNT(CT.MASH) AS SoSachMuon
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
GROUP BY DG.HOTEN;

--3  Tìm tên độc giả và tên sách mà họ đã mượn kèm theo ghi chú.
SELECT DG.HOTEN, S.TENSACH, CT.GHICHU
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN SACH S ON CT.MASH = S.MASH;

--4  Liệt kê độc giả có nghề nghiệp là “Bác sĩ” hoặc “Giám đốc” đã mượn sách xuất bản sau năm 2020.
SELECT DISTINCT DG.HOTEN, S.TENSACH, S.NAMXB, DG.NGHENGHIEP
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN SACH S ON CT.MASH = S.MASH
WHERE DG.NGHENGHIEP IN (N'Bác sĩ', N'Giám đốc') AND S.NAMXB > 2020;

--Bùi Trịnh Khánh Linh - 23686531
--1 Liệt kê tất cả các nhà xuất bản khác nhau.
SELECT DISTINCT NHAXB
FROM SACH;

--2  Liệt kê tên độc giả và số lượng sách họ đã mượn
SELECT DG.HOTEN, PM.SOPM
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
GROUP BY DG.HOTEN, PM.SOPM;
--3 Liệt kê những cuốn sách chưa từng được mượn.
SELECT S.TENSACH
FROM SACH S
LEFT JOIN CT_PHIEUMUON CT ON S.MASH = CT.MASH
WHERE CT.MASH IS NULL;

--4 Liệt kê tất cả các độc giả từng mượn sách có ghi chú chứa từ “nghiên cứu”.
SELECT DISTINCT DG.HOTEN, CT.GHICHU
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
WHERE CT.GHICHU LIKE N'%nghiên cứu%';

--Lâm Thị Ngọc Tuyền - 23677091
--Câu 1:  Liệt kê các tác giả có ít nhất một sách xuất bản trong năm 2021.
SELECT DISTINCT TACGIA
FROM SACH
WHERE NAMXB = 2021;

--Câu 2: liệt kê những cuốn sách nào đã được mượn và ai là người đã mượn chúng trong một khoảng thời gian cụ thể?

SELECT D.HOTEN, S.TENSACH, PM.NGAYMUON
FROM CT_PHIEUMUON CT
JOIN SACH S ON CT.MASH = S.MASH
JOIN PHIEUMUON PM ON CT.SOPM = PM.SOPM
JOIN DOCGIA D ON PM.MADG = D.MADG;

--CÂU 3 : Tên và địa chỉ của những bạn đọc đã từng mượn sách 'Marketing căn bản'
SELECT DG.HOTEN, DG.DIACHI
FROM DOCGIA DG
JOIN PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN SACH S ON CT.MASH = S.MASH
WHERE S.TENSACH = N'Marketing căn bản';


--CÂU 4: Tìm các phiếu mượn được lập vào tháng 11/2023.
SELECT SOPM, NGAYMUON
FROM PHIEUMUON
WHERE MONTH(NGAYMUON) = 11 AND YEAR(NGAYMUON)
= 2023;



--Câu hỏi bổ sung của thầy: Xóa độc giả đã mượn cuốn sách 'Kỹ năng sống'
-- Xóa chi tiết phiếu mượn của sách "Kỹ năng sống"
DELETE CT
FROM dbo.CT_PHIEUMUON CT
JOIN dbo.PHIEUMUON PM ON CT.SOPM = PM.SOPM
JOIN dbo.SACH S ON CT.MASH = S.MASH
WHERE S.TENSACH = N'Kỹ năng sống';

-- Xóa phiếu mượn liên quan đến sách "Kỹ năng sống"
DELETE PM
FROM dbo.PHIEUMUON PM
WHERE EXISTS (
    SELECT 1 
    FROM dbo.CT_PHIEUMUON CT
    JOIN dbo.SACH S ON CT.MASH = S.MASH
    WHERE CT.SOPM = PM.SOPM AND S.TENSACH = N'Kỹ năng sống'
);

-- Cuối cùng xóa độc giả
DELETE FROM dbo.DOCGIA
WHERE MADG IN (
    SELECT PM.MADG
    FROM dbo.PHIEUMUON PM
    JOIN dbo.CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
    JOIN dbo.SACH S ON CT.MASH = S.MASH
    WHERE S.TENSACH = N'Kỹ năng sống'
);
 
--SELECT NHÌN TỔNG QUAN 
SELECT 
    DG.HOTEN AS [Họ tên độc giả],
    S.TENSACH AS [Tên sách],
    PM.NGAYMUON AS [Ngày mượn],
    CT.NGAYTRA AS [Ngày trả],
    CT.GHICHU AS [Ghi chú]
FROM dbo.DOCGIA DG
JOIN dbo.PHIEUMUON PM ON DG.MADG = PM.MADG
JOIN dbo.CT_PHIEUMUON CT ON PM.SOPM = CT.SOPM
JOIN dbo.SACH S ON CT.MASH = S.MASH
ORDER BY DG.HOTEN;


