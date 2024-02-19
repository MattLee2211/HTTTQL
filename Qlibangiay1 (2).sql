
CREATE TABLE THU_HANG (
    Ma_Thu_Hang Varchar2(5) PRIMARY KEY NOT NULL,
    Ten_Thu_Hang VARCHAR2(10),
    Mo_Ta_Quyen_Loi VARCHAR2(200)
);

CREATE TABLE KHACH_HANG (
    Ma_Khach_Hang VARCHAR2(5) CONSTRAINT kh_pk PRIMARY KEY NOT NULL,
    Ten_Khach_Hang VARCHAR2(50),
    Gioi_Tinh VARCHAR2(5),
    Ngay_Sinh DATE,
    So_DT VARCHAR2(15),
    Dia_Chi VARCHAR2(100),
    Ma_Thu_Hang VARCHAR2(5),
    CONSTRAINT kh_th_fk FOREIGN KEY (Ma_Thu_Hang) REFERENCES THU_HANG(Ma_Thu_Hang)
);

CREATE TABLE LOAI_SAN_PHAM (
    Ma_Loai Varchar2(6) PRIMARY KEY NOT NULL,
    Ten_Loai VARCHAR2(50)
);
CREATE TABLE Nha_Cung_Cap (
    Ma_NCC varchar2(6) PRIMARY KEY NOT NULL,
    Ten_NCC VARCHAR2(50),
    SDT CHAR(15),
    Dia_Chi_NCC VARCHAR2(50)
);
CREATE TABLE KHO (
    Ma_Kho varchar2(4) PRIMARY KEY NOT NULL,
    Ten_Kho VARCHAR2(50),
    Dia_Chi_Kho VARCHAR2(100)
);
CREATE TABLE TON_KHO (
    Ma_Kho VARCHAR2(4),
    Ma_San_Pham VARCHAR2(5),
    So_Luong INT,
    PRIMARY KEY (Ma_Kho, Ma_San_Pham)
);
CREATE TABLE SAN_PHAM (
    Ma_San_Pham Varchar2(5) constraint sp_pk PRIMARY KEY NOT NULL,
    Ten_San_Pham VARCHAR2(50),
    Trang_Thai INT;
    Mau_Sac VARCHAR2(100),
    Chat_Lieu VARCHAR2(100),
    Gia_Ban NUMBER(10,2),
    Ma_NCC varchar2(6),
    Ma_Loai Varchar2(6),
    Ma_Kho varchar2(4),
    Constraint sp_ncc_pk FOREIGN KEY (Ma_NCC) REFERENCES Nha_Cung_Cap(Ma_NCC),
    Constraint sp_lsp_pk FOREIGN KEY (Ma_Loai) REFERENCES LOAI_SAN_PHAM(Ma_Loai),
    Constraint sp_kho_pk FOREIGN KEY (Ma_Kho) REFERENCES Kho(Ma_Kho)
);
CREATE TABLE CHUC_VU (
    Ma_Chuc_Vu varchar2(5) PRIMARY KEY NOT NULL,
    Ten_Chuc_Vu VARCHAR2(50)
);


CREATE TABLE NHAN_VIEN (
    Ma_Nhan_Vien varchar2(5) constraint nv1_pk PRIMARY KEY NOT NULL,
    Ten_Nhan_Vien VARCHAR2(50),
    CCCD INT NOT NULL,
    Gioi_Tinh VARCHAR2(5),
    Ngay_Sinh DATE ,
    Dia_Chi VARCHAR2(100),
    SDT CHAR(20),
    Ma_Chuc_Vu varchar2(5),
  Constraint nv1_cv_pk  FOREIGN KEY (Ma_Chuc_Vu) REFERENCES CHUC_VU(Ma_Chuc_Vu)
);

CREATE TABLE HOA_DON (
    Ma_Hoa_Don varchar2(5) CONSTRAINT hd_pk PRIMARY KEY NOT NULL,
    Ma_Nhan_Vien varchar2(5),
    Ngay_Hoa_Don DATE,
    Phuong_Thuc_Van_Chuyen VARCHAR2(100),
    Phuong_Thuc_Thanh_Toan VARCHAR2(50),
    Ngay_Giao DATE,
    Tong_Tien NUMBER(10,2),
    CONSTRAINT hd_nv_pk FOREIGN KEY (Ma_Nhan_Vien) REFERENCES NHAN_VIEN(Ma_Nhan_Vien),
    CONSTRAINT check_ngay_giao CHECK (Ngay_Giao >= Ngay_Hoa_Don)
);

CREATE TABLE CHI_TIET_BAN_HANG (
    Ma_Hoa_Don varchar2(5),
    Ma_San_Pham varchar2(5),
    Ma_Khach_Hang varchar2(5),
    Ma_Nhan_Vien varchar2(5) ,
    So_Luong_SP INT NOT NULL,
    Thanh_Tien NUMBER(10,2),
  Constraint ctbh_pk  PRIMARY KEY (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien),
  Constraint ctbh_hd_pk  FOREIGN KEY (Ma_Hoa_Don) REFERENCES HOA_DON(Ma_Hoa_Don),
  Constraint ctbh_sp_pk    FOREIGN KEY (Ma_San_Pham) REFERENCES SAN_PHAM(Ma_San_Pham),
  Constraint ctbh_kh_pk    FOREIGN KEY (Ma_Khach_Hang) REFERENCES KHACH_HANG(Ma_Khach_Hang),
  Constraint ctbh_nv_pk    FOREIGN KEY (Ma_Nhan_Vien) REFERENCES NHAN_VIEN(Ma_Nhan_Vien)
);

CREATE TABLE DON_NHAP_HANG (
    Ma_Don_Nhap varchar2(5) CONSTRAINT dnh_pk PRIMARY KEY NOT NULL,
    Ma_Nhan_Vien varchar2(5),
    Ngay_Dat_Hang DATE,
    Ngay_Nhan_Hang DATE,
    Phuong_Thuc_Thanh_Toan VARCHAR2(50),
    Phuong_Thuc_Giao_Hang VARCHAR2(100),
    Tong_Tien NUMBER(10,2),
    CONSTRAINT dnh_nv_pk FOREIGN KEY (Ma_Nhan_Vien) REFERENCES NHAN_VIEN(Ma_Nhan_Vien),
    CONSTRAINT check_ngay_nhan_ngay_dat CHECK (Ngay_Nhan_Hang >= Ngay_Dat_Hang)
);
CREATE TABLE CHI_TIET_NHAP_HANG (
    Ma_Don_Nhap varchar2(5),
    Ma_San_Pham varchar2(5),
    Don_Gia_Nhap NUMBER(10,2),
    So_Luong_Nhap INT NOT NULL,
  Constraint ctnh_pk  PRIMARY KEY (Ma_Don_Nhap, Ma_San_Pham),
  Constraint ctnh_dnh_pk      FOREIGN KEY (Ma_Don_Nhap) REFERENCES DON_NHAP_HANG(Ma_Don_Nhap),
  Constraint ctnh_sp_pk    FOREIGN KEY (Ma_San_Pham) REFERENCES SAN_PHAM(Ma_San_Pham)
);

INSERT INTO THU_HANG (Ma_Thu_Hang, Ten_Thu_Hang, Mo_Ta_Quyen_Loi)
VALUES('TH001', 'Vang', 'Muc uu dai cao, nhieu quyen loi hap dan');
INSERT INTO THU_HANG (Ma_Thu_Hang, Ten_Thu_Hang, Mo_Ta_Quyen_Loi)
VALUES('TH002', 'Bac', 'Muc uu dai trung binh, mot so quyen loi');
INSERT INTO THU_HANG (Ma_Thu_Hang, Ten_Thu_Hang, Mo_Ta_Quyen_Loi)
VALUES('TH003', 'Dong', 'Muc uu dai thap, it quyen loi');

INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH001', 'Nguyen Van Nam', 'Nam', TO_DATE('1990-01-01', 'YYYY-MM-DD'), '0123456789', 'Ha Noi', 'TH001');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES ('KH002', 'Tran Thi Quyen', 'Nu', TO_DATE('1985-05-10', 'YYYY-MM-DD'), '0987654321', 'Hai Duong', 'TH002');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES ('KH003', 'Le Van Minh', 'Nam', TO_DATE('1995-08-15', 'YYYY-MM-DD'), '0345678901', 'Hai Phong', 'TH003');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH004', 'Pham Thi Duong', 'Nu', TO_DATE('1982-03-20', 'YYYY-MM-DD'), '0765432109', 'Quang Ninh', 'TH001');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH005', 'Hoang Van Duc', 'Nam', TO_DATE('1993-12-05', 'YYYY-MM-DD'), '0234567890', 'Bac Ninh', 'TH002');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH006', 'Nguyen Thi Mai', 'Nu', TO_DATE('1987-07-18', 'YYYY-MM-DD'), '0456789012', 'Ha Noi', 'TH003');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH007', 'Tran Van Tien', 'Nam', TO_DATE('1998-02-28', 'YYYY-MM-DD'), '0567890123', 'Nam Dinh', 'TH001');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH008', 'Le Thi Hoa', 'Nu', TO_DATE('1980-09-10', 'YYYY-MM-DD'), '0678901234', 'Hai Duong', 'TH002');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH009', 'Pham Van Duc', 'Nam', TO_DATE('1991-06-25', 'YYYY-MM-DD'), '0789012345', 'Yen Bai', 'TH003');
INSERT INTO KHACH_HANG (Ma_Khach_Hang, Ten_Khach_Hang, Gioi_Tinh, Ngay_Sinh, So_DT, Dia_Chi, Ma_Thu_Hang)
VALUES('KH010', 'Ho Thi Khanh', 'Nu', TO_DATE('1984-11-15', 'YYYY-MM-DD'), '0890123456', 'Quang Ninh', 'TH001');

INSERT INTO CHUC_VU (Ma_Chuc_Vu, Ten_Chuc_Vu)
VALUES    ('CV001', 'Quan li');
INSERT INTO CHUC_VU (Ma_Chuc_Vu, Ten_Chuc_Vu)
VALUES   ('CV003', 'Nhan vien ban hang');

INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV001', 'Nguyen Van Quan', 123456789, 'Nam', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'Ha Noi', '01234567890', 'CV001');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV003', 'Le Van Bao', 345678901, 'Nam', TO_DATE('1990-08-15', 'YYYY-MM-DD'), 'Hai Duong', '03456789012','CV003');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV004', 'Pham Thi Bao Thy', 456789012, 'Nu', TO_DATE('1982-03-20', 'YYYY-MM-DD'), 'Ha Noi', '07654321098', 'CV003');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV005', 'Hoang Van Bach', 567890123, 'Nam', TO_DATE('1993-12-05', 'YYYY-MM-DD'), 'Hai Phong', '02345678901', 'CV003');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV006', 'Nguyen Thi Bao Linh', 678901234, 'Nu', TO_DATE('1987-07-18', 'YYYY-MM-DD'), 'Nam Dinh', '04567890123', 'CV003');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV007', 'Tran Van Nam', 789012345, 'Nam', TO_DATE('1998-02-28', 'YYYY-MM-DD'), 'Quang Binh', '05678901234', 'CV003');
INSERT INTO NHAN_VIEN (Ma_Nhan_Vien, Ten_Nhan_Vien, CCCD, Gioi_Tinh, Ngay_Sinh, Dia_Chi, SDT, Ma_Chuc_Vu)
VALUES('NV008', 'Le Thi Kha Ngan', 890123456, 'Nu', TO_DATE('1980-09-10', 'YYYY-MM-DD'), 'Ha Nam', '06789012345', 'CV003');

INSERT INTO LOAI_SAN_PHAM (Ma_Loai, Ten_Loai)
VALUES('LSP001', 'Boots');
INSERT INTO LOAI_SAN_PHAM (Ma_Loai, Ten_Loai)
VALUES('LSP002', 'Sneakers');
INSERT INTO LOAI_SAN_PHAM (Ma_Loai, Ten_Loai)
VALUES('LSP003', 'Sandals');
INSERT INTO LOAI_SAN_PHAM (Ma_Loai, Ten_Loai)
VALUES('LSP004', 'Bup Be');
INSERT INTO LOAI_SAN_PHAM (Ma_Loai, Ten_Loai)
VALUES('LSP005', 'Cao got');

INSERT INTO Nha_Cung_Cap (Ma_NCC, Ten_NCC, SDT, Dia_Chi_NCC)
VALUES('NCC1', 'Sneakers Hoàng Huy', '0123456789', 'Ha Noi');
INSERT INTO Nha_Cung_Cap (Ma_NCC, Ten_NCC, SDT, Dia_Chi_NCC)
VALUES('NCC2', 'Giay dep gia re', '0987654321', 'Hai Duong');
INSERT INTO Nha_Cung_Cap (Ma_NCC, Ten_NCC, SDT, Dia_Chi_NCC)
VALUES('NCC3', 'NiceShoes', '0345678901', 'Ha Noi');
INSERT INTO Nha_Cung_Cap (Ma_NCC, Ten_NCC, SDT, Dia_Chi_NCC)
VALUES('NCC4', 'Streetwears Khoi', '0765432109', 'Ho Chi Minh');
INSERT INTO Nha_Cung_Cap (Ma_NCC, Ten_NCC, SDT, Dia_Chi_NCC)
VALUES('NCC5', 'Chuyen si giay quang chau cao cap', '0234567890', 'Bac Ninh');

INSERT INTO KHO (Ma_Kho, Ten_Kho, Dia_Chi_Kho)
VALUES('K001', 'Kho Hoang Mai', '123 Dinh Cong, Hoang Mai, Ha Noi');
INSERT INTO KHO (Ma_Kho, Ten_Kho, Dia_Chi_Kho)
VALUES('K002', 'Kho Dong Da', '12 Chua Boc, Dong Da, Ha Noi');
INSERT INTO KHO (Ma_Kho, Ten_Kho, Dia_Chi_Kho)
VALUES('K003', 'Kho Cau Giay', '54 Ho Tung Mau, Cau Giay, Ha Noi');
select*from hoa_don
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K001', 'SP001', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K002', 'SP002', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K003', 'SP003', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K001', 'SP004', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K002', 'SP005', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K003', 'SP006', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K001', 'SP007', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K002', 'SP008', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K003', 'SP009', 100);
INSERT INTO TON_KHO (Ma_Kho, Ma_San_Pham, So_Luong)
VALUES('K001', 'SP010', 100);
select*from Ton_kho


INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP001', 'Giay bup be Venus', 1, 'Den', 'Da', 240000, 'NCC5', 'LSP004','K001');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP002', 'Giay bup be Pedro', 1, 'Trang', 'Da bóng', 340000, 'NCC5', 'LSP004','K002');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP003', 'Giay cao got Anne', 1, 'Den', 'Da', 400000, 'NCC3', 'LSP005','K003');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP004', 'Giay cao got Mike', 1, 'Bac', 'Nhung', 290000, 'NCC2', 'LSP005','K001');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP005', 'Nike air max', 1, 'Trang', 'Vai',5400000, 'NCC1', 'LSP002','K003');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP006', 'New Balance 327', 1, 'Trang', 'Vai', 440000, 'NCC4', 'LSP002','K002');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP007', 'Bullin Boots', 1, 'Den', 'Da bóng', 740000, 'NCC5', 'LSP001','K001');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP008', 'Boots Crowd', 1, 'Trang', 'Da', 840000, 'NCC4', 'LSP001','K002');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP009', 'Converse Jeans', 1, 'Den', 'Vai', 520000, 'NCC4', 'LSP002','K003');
INSERT INTO SAN_PHAM (Ma_San_Pham, Ten_San_Pham, Trang_Thai, Mau_Sac, Chat_Lieu, Gia_Ban, Ma_NCC, Ma_Loai, Ma_Kho)
VALUES('SP010', 'Sandals Nira', 1, 'Trang', 'Nhua', 140000, 'NCC1', 'LSP003','K001');

INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES    ('HD001','NV003', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Giao hang nhanh', 'Thanh toan khi nhan hang', TO_DATE('2023-11-03', 'YYYY-MM-DD'), 580000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD002', 'NV004', TO_DATE('2023-11-02', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'Chuyen khoan ngan hang', TO_DATE('2023-11-04', 'YYYY-MM-DD'), 1310000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD003', 'NV005', TO_DATE('2023-11-03', 'YYYY-MM-DD'), 'Giao hang nhanh', 'The tin dung', TO_DATE('2023-11-05', 'YYYY-MM-DD'), 1820000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD004', 'NV006', TO_DATE('2023-11-04', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'Tien mat', TO_DATE('2023-11-06', 'YYYY-MM-DD'), 2420000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD005','NV007', TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Giao hàng nhanh', 'Chuyen khoan ngan hang', TO_DATE('2023-11-07', 'YYYY-MM-DD'), 720000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD006', 'NV008', TO_DATE('2023-11-06', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'The tin dung', TO_DATE('2023-11-08', 'YYYY-MM-DD'), 1880000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD007', 'NV008', TO_DATE('2023-11-07', 'YYYY-MM-DD'), 'Giao hang nhanh', 'Thanh toán khi nhan hang', TO_DATE('2023-11-09', 'YYYY-MM-DD'), 3100000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES('HD008', 'NV007', TO_DATE('2023-11-08', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'Chuyen khoan ngan hang', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 16800000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES    ('HD009','NV003', TO_DATE('2023-11-09', 'YYYY-MM-DD'), 'Giao hang nhanh', 'The tin dung', TO_DATE('2023-11-11', 'YYYY-MM-DD'), 2800000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES    ('HD010', 'NV006', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'Tien mat', TO_DATE('2023-11-12', 'YYYY-MM-DD'),3260000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES    ('HD011','NV007', TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Giao hang nhanh', 'The tin dung', TO_DATE('2023-11-07', 'YYYY-MM-DD'), 2800000);
INSERT INTO HOA_DON (Ma_Hoa_Don, Ma_Nhan_Vien, Ngay_Hoa_Don, Phuong_Thuc_Van_Chuyen, Phuong_Thuc_Thanh_Toan, Ngay_Giao, Tong_Tien)
VALUES    ('HD012', 'NV003', TO_DATE('2023-11-07', 'YYYY-MM-DD'), 'Giao hang tieu chuan', 'Tien mat', TO_DATE('2023-11-09', 'YYYY-MM-DD'),3260000);

INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD001', 'SP001', 'KH001', 'NV003', 1, 240000);
INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD002', 'SP004', 'KH002', 'NV004', 1, 290000);
INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD003', 'SP007', 'KH003', 'NV005', 1, 740000);
INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD004', 'SP009', 'KH004', 'NV006', 2, 1680000);
INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD005', 'SP001', 'KH0010', 'NV007', 2, 480000);
INSERT INTO CHI_TIET_BAN_HANG (Ma_Hoa_Don, Ma_San_Pham, Ma_Khach_Hang, Ma_Nhan_Vien, So_Luong_SP, Thanh_Tien) VALUES ('HD006', 'SP003', 'KH005', 'NV008', 2, 800000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN001', 'NV001', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'), 'Chuy?n kho?n ngân hàng', 'Giao hàng nhanh', 24000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN002', 'NV001', TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), 'Thanh toán khi nh?n hàng', 'Giao hàng tiêu chu?n', 34000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN003', 'NV001', TO_DATE('2023-11-03', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Ti?n m?t', 'Giao hàng nhanh', 40000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN004', 'NV001', TO_DATE('2023-11-04', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), 'Chuyen khoan ngan hang', 'Giao hang tieu chuan', 29000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN005', 'NV001', TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'), 'The tin dung', 'Giao hang nhanh', 52000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN006', 'NV001', TO_DATE('2023-11-06', 'YYYY-MM-DD'), TO_DATE('2023-11-08', 'YYYY-MM-DD'), 'Chuyen khoan ngan hang', 'Giao hang tieu chuan', 14000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN007', 'NV001', TO_DATE('2023-11-07', 'YYYY-MM-DD'), TO_DATE('2023-11-09', 'YYYY-MM-DD'), 'Thanh toan khi nhan hang', 'Giao hang nhanh', 74000000);

INSERT INTO DON_NHAP_HANG (Ma_Don_Nhap, Ma_Nhan_Vien, Ngay_Dat_Hang, Ngay_Nhan_Hang, Phuong_Thuc_Thanh_Toan, Phuong_Thuc_Giao_Hang, Tong_Tien)
VALUES ('DN008', 'NV001', TO_DATE('2023-11-08', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Chuyen khoan ngan hang', 'Giao hang tieu chuan', 42000000);


INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN001', 'SP001', 240000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN002', 'SP002', 340000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN003', 'SP003', 400000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN004', 'SP004', 290000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN005', 'SP009', 520000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN006', 'SP010', 140000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN007', 'SP007', 740000, 100);
INSERT INTO CHI_TIET_NHAP_HANG (Ma_Don_Nhap, Ma_San_Pham, Don_Gia_Nhap, So_Luong_Nhap) VALUES ('DN008', 'SP008', 840000, 50);


--Tao tablespace
CREATE TABLESPACE DT1
     DATAFILE 'C:\APP\ORACLE\ORADATA\QLIBANGIAY1\DT1.DBF' SIZE 100m
     AUTOEXTEND ON NEXT 100m MAXSIZE 100M
     EXTENT MANAGEMENT LOCAL;
Alter table kho move tablespace DT1;
Alter table ton_kho move tablespace DT1;
Alter table hoa_don move tablespace DT1;
Alter table chi_tiet_ban_hang move tablespace DT1;
Alter table don_nhap_hang move tablespace DT1;
Alter table chi_tiet_nhap_hang move tablespace DT1;
     
CREATE TABLESPACE DT2
     DATAFILE 'C:\APP\ORACLE\ORADATA\QLIBANGIAY1\DT2.DBF' SIZE 200m
     AUTOEXTEND ON NEXT 200m MAXSIZE 1024M
     EXTENT MANAGEMENT LOCAL;

Alter table thu_hang move tablespace DT2;
Alter table khach_hang move tablespace DT2;
Alter table loai_san_pham move tablespace DT2;
Alter table nha_cung_cap move tablespace DT2;
Alter table san_pham move tablespace DT2;
Alter table chuc_vu move tablespace DT2;
Alter table nhan_vien move tablespace DT2;



----------USER QUAN LY------------
CREATE USER quanly IDENTIFIED BY 123  ;
-- QUOTAS
ALTER USER quanly QUOTA UNLIMITED ON DT2;
-- PRIVILEGES
GRANT CREATE SESSION TO quanly with admin option;
GRANT SELECT, INSERT, UPDATE ON thu_hang TO quanly;
GRANT SELECT, INSERT, UPDATE ON khach_hang TO quanly;
GRANT SELECT, INSERT, UPDATE ON loai_san_pham TO quanly;
GRANT SELECT, INSERT, UPDATE ON nha_cung_cap TO quanly;
GRANT SELECT, INSERT, UPDATE ON san_pham TO quanly;
GRANT SELECT, INSERT, UPDATE ON chuc_vu TO quanly;
GRANT SELECT, INSERT, UPDATE ON nhan_vien TO quanly;
GRANT SELECT, INSERT ON kho TO quanly;
GRANT SELECT, INSERT ON ton_kho TO quanly;
GRANT SELECT, INSERT ON hoa_don TO quanly;
GRANT SELECT, INSERT ON chi_tiet_ban_hang TO quanly;
GRANT SELECT, INSERT ON don_nhap_hang TO quanly;
GRANT SELECT, INSERT ON chi_tiet_nhap_hang TO quanly;


----------USER NHAN VIEN------------
CREATE USER nhanvien IDENTIFIED BY 123  ;
-- QUOTAS
ALTER USER nhanvien QUOTA UNLIMITED ON DT2;
-- PRIVILEGES
GRANT CREATE SESSION TO nhanvien;
GRANT SELECT, INSERT, UPDATE khach_hang TO nhanvien;
GRANT SELECT ON thu_hang TO nhanvien;
GRANT SELECT ON loai_san_pham TO nhanvien;
GRANT SELECT ON nha_cung_cap TO nhanvien;
GRANT SELECT ON kho TO nhanvien;
GRANT SELECT ON ton_kho TO nhanvien;
GRANT SELECT ON san_pham TO nhanvien;
GRANT SELECT ON hoa_don TO nhanvien;
GRANT SELECT ON chi_tiet_ban_hang TO nhanvien;
GRANT SELECT ON don_nhap_hang TO nhanvien;
GRANT SELECT ON chi_tiet_nhap_hang TO nhanvien;

----------USER QUAN TRI IT--------
CREATE USER quantriit IDENTIFIED BY 123  ;
-- QUOTAS
ALTER USER quantriit QUOTA UNLIMITED ON DT1;
ALTER USER quantriit QUOTA UNLIMITED ON DT2;
-- PRIVILEGES
GRANT CREATE SESSION TO quantriit with admin option;
GRANT DBA TO quantriit;
GRANT CONNECT TO quantriit;
GRANT RESOURCE TO quantriit;
ALTER USER quantriit DEFAULT ROLE DBA;



--truy van SQL--
--1.L?y thông tin chi ti?t ??n hàng:	
SELECT *
FROM CHI_TIET_BAN_HANG
WHERE Ma_Hoa_Don = 'HD001';

--2.Tìm ki?m s?n ph?m theo tên và lo?i:
SELECT *
FROM SAN_PHAM
WHERE Ten_San_Pham LIKE 'Giày búp bê Venus' AND Ma_Loai = 'LSP004';
			
--3.Th?ng kê doanh thu theo ngày:	
SELECT Ngay_Hoa_Don, SUM(Tong_Tien) AS Tong_Doanh_Thu
FROM HOA_DON
GROUP BY Ngay_Hoa_Don;
		
--4.L?y danh sách s?n ph?m có s? l??ng t?n kho d??i m?c t?i thi?u:
SELECT *
FROM SAN_PHAM
WHERE So_Luong_Ton_Kho < 7;
		
--5.Danh sách nhân viên có ??n hàng nhi?u nh?t:
SELECT Nhan_vien.Ma_Nhan_vien, Ten_Nhan_vien, COUNT(HOA_DON.Ma_Hoa_Don) AS So_Don_Hang
FROM NHAN_VIEN
JOIN HOA_DON ON NHAN_VIEN.Ma_Nhan_vien = HOA_DON.Ma_Nhan_vien
GROUP BY Nhan_vien.Ma_Nhan_vien, Ten_Nhan_vien
ORDER BY So_Don_Hang DESC;


--6.T?ng doanh thu theo nhân viên:
SELECT Nhan_vien.Ma_Nhan_vien, Ten_Nhan_vien, SUM(Tong_Tien) AS Tong_Doanh_Thu
FROM Nhan_vien
JOIN HOA_DON ON Nhan_vien.Ma_Nhan_vien = HOA_DON.Ma_Nhan_vien
GROUP BY Nhan_vien.Ma_Nhan_vien, Ten_Nhan_vien;	

--7.Danh sách nhà cung c?p theo s? l??ng s?n ph?m cung c?p:
SELECT Nha_Cung_Cap.Ma_NCC, Ten_NCC, COUNT(Ma_San_Pham) AS So_San_Pham_Cung_Cap
FROM Nha_Cung_Cap
JOIN SAN_PHAM ON Nha_Cung_Cap.Ma_NCC = SAN_PHAM.Ma_NCC
GROUP BY Nha_Cung_Cap.Ma_NCC, Ten_NCC
ORDER BY So_San_Pham_Cung_Cap DESC;

--8.T?ng doanh thu theo lo?i s?n ph?m:
SELECT LOAI_SAN_PHAM.Ma_Loai, Ten_Loai, SUM(Tong_Tien) AS Tong_Doanh_Thu
FROM LOAI_SAN_PHAM
JOIN SAN_PHAM ON LOAI_SAN_PHAM.Ma_Loai = SAN_PHAM.Ma_Loai
JOIN CHI_TIET_BAN_HANG ON SAN_PHAM.Ma_San_Pham = CHI_TIET_BAN_HANG.Ma_San_Pham
JOIN HOA_DON ON CHI_TIET_BAN_HANG.Ma_Hoa_Don = HOA_DON.Ma_Hoa_Don
GROUP BY LOAI_SAN_PHAM.Ma_Loai, Ten_Loai;

--9.Danh sách ??n nh?p hàng theo ngày:	
SELECT *
FROM DON_NHAP_HANG
WHERE Ngay_Nhan_Hang = TO_DATE('2023-11-03', 'YYYY-MM-DD');

--10.Danh sách nh?ng s?n ph?m ???c ??t hàng nhi?u nh?t:
SELECT SAN_PHAM.Ma_San_Pham, Ten_San_Pham, SUM(So_Luong_SP) AS Tong_So_Luong_Dat_Hang
FROM SAN_PHAM
JOIN CHI_TIET_BAN_HANG ON SAN_PHAM.Ma_San_Pham = CHI_TIET_BAN_HANG.Ma_San_Pham
GROUP BY SAN_PHAM.Ma_San_Pham, Ten_San_Pham
ORDER BY Tong_So_Luong_Dat_Hang DESC;


-- PLSQL--
--thu tuc--
create or replace procedure cap_nhat_van_chuyen(
    mahoadon in HOA_DON.Ma_Hoa_Don%type
) as
    ngaygiao date;
    thongbao varchar2(50);
begin
    select Ngay_Giao into ngaygiao
    from HOA_DON
    where Ma_Hoa_Don = mahoadon;
    if ngaygiao < sysdate then
        thongbao := 'Da giao hang';
    else thongbao := 'Chua giao hang';
    end if;
    dbms_output.put_line('Ma hoa don: ' || mahoadon);
    dbms_output.put_line('Thong bao van chuyen: ' || thongbao);
end;
execute cap_nhat_van_chuyen('&mahoadon');

--Tinh tong gia tri don nhap hang theo NCC--
create or replace procedure tinh_tong_gia_tri_don_nhap_theo_NCC(
    mancc in Nha_Cung_Cap.Ma_NCC%type
) as
    tong_gia_tri number := 0;
begin
    select NVL(sum(dnh.Tong_Tien), 0)
    into tong_gia_tri
    from Don_Nhap_Hang dnh
    join Chi_Tiet_Nhap_Hang ctnh on dnh.Ma_Don_Nhap = ctnh.Ma_Don_Nhap
    join San_Pham sp on ctnh.Ma_San_Pham = sp.Ma_San_Pham
    where sp.Ma_NCC = mancc;
    dbms_output.put_line('Tong giá tri don nhap hàng cua Nhà Cung Cap ' || mancc || ': ' || tong_gia_tri);
end;
execute tinh_tong_gia_tri_don_nhap_theo_NCC('&mancc');

--Tinh tong chi tieu cua khach hang trong thang 11 khi nhap vao ma khach hang
create or replace procedure TongChiTieuKhachHangThang11(
    makh in KHACH_HANG.Ma_Khach_Hang%type
)
as
    Tongct number;
begin
    select NVL(sum(hd.Tong_Tien), 0)
    into Tongct
    from HOA_DON hd
    join CHI_TIET_BAN_HANG ct on hd.Ma_Hoa_Don = ct.Ma_Hoa_Don
    where ct.Ma_Khach_Hang = makh and extract(month from hd.Ngay_Hoa_Don) = 11;
    dbms_output.put_line('Tong so tien khach hang ' || makh || ' da chi tiêu trong tháng 11: ' || Tongct);
END;

set serveroutput on
execute  TongChiTieuKhachHangThang11('&makh');

--PL/SQL
--nhap vao ten nhan vien, cho biet nhan vien do co trong CSDL hay khong
set serveroutput on 
declare
    tennv varchar2(25);
begin
    tennv := ('&tennv');
    for rec in (select 1 from NHAN_VIEN where tennv= Ten_Nhan_Vien ) 
    loop
        dbms_output.put_line('Nhan vien ' || tennv || ' ton tai trong CSDL');
        RETURN;
    end loop;
    dbms_output.put_line('Nhan vien ' || tennv || ' khong ton tai trong CSDL');
end;


---Nhap vao ma nhan vien, cho biet so don ban hang ho thuc hien
set serveroutput on
declare
  manv varchar(5);
  sodonbh number;
begin
  manv := '&ma_nhan_vien';
  select count(Ma_Hoa_Don) into sodonbh
  from hoa_don
  where Ma_Nhan_Vien = manv;
  if sodonbh > 0 then
    dbms_output.put_line('Nhan vien ' || manv || ' da ban duoc ' || sodonbh || ' don.');
  else
    dbms_output.put_line('Nhan vien ' || manv || ' chua thuc hien don nao.');
  end if;
end;

--trigger
-- Ki?m tra SDT c?a khách hàng va NCC
CREATE OR REPLACE TRIGGER kiem_tra_sdt_khach_hang
BEFORE INSERT OR UPDATE ON KHACH_HANG
FOR EACH ROW
BEGIN
    IF :new.So_DT IS NOT NULL AND NOT REGEXP_LIKE(:new.So_DT, '^[0-9]+$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'SDT cua khach hang chi duoc chua chu so.');
    END IF;
END;


CREATE OR REPLACE TRIGGER kiem_tra_sdt_ncc
BEFORE INSERT OR UPDATE ON Nha_Cung_Cap
FOR EACH ROW
BEGIN
    IF :new.SDT IS NOT NULL AND NOT REGEXP_LIKE(:new.SDT, '^[0-9]+$') THEN
        RAISE_APPLICATION_ERROR(-20002, 'SDT c?a nha cung cap chi duoc chua chu so.');
    END IF;
END;

--Kiem tra tuoi cua nhan vien

CREATE OR REPLACE TRIGGER kiem_tra_tuoinv
BEFORE INSERT OR UPDATE ON NHAN_VIEN
FOR EACH ROW
DECLARE
    	tuoi  NUMBER;
BEGIN
 	tuoi := EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM :NEW.Ngay_Sinh);
    	IF tuoi < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Tuoi cua nhan vien phai lon hon hoac bang 18.');
    END IF;
END;

--ham--
--Tinh tong doanh thu theo 1 khoang thoi gian
CREATE OR REPLACE FUNCTION tinh_tong_doanh_thu_khoang_thoi_gian (
    ngay_bat_dau IN DATE,
    ngay_ket_thuc IN DATE
) RETURN NUMBER IS
    tong_doanh_thu NUMBER := 0;
BEGIN
    SELECT SUM(Tong_Tien)
    INTO tong_doanh_thu
    FROM HOA_DON
    WHERE Ngay_Hoa_Don BETWEEN ngay_bat_dau AND ngay_ket_thuc;
    RETURN tong_doanh_thu;
END tinh_tong_doanh_thu_khoang_thoi_gian;

SET SERVEROUTPUT ON;
ACCEPT ngay_bat_dau DATE FORMAT 'YYYY-MM-DD' PROMPT 'Nhap ngay bat dau: ';
ACCEPT ngay_ket_thuc DATE FORMAT 'YYYY-MM-DD' PROMPT 'Nhap ngay ket thuc: ';

DECLARE
    ngay_bat_dau DATE;
    ngay_ket_thuc DATE;
    doanh_thu NUMBER;
BEGIN
    ngay_bat_dau := TO_DATE('&ngay_bat_dau', 'YYYY-MM-DD');
    ngay_ket_thuc := TO_DATE('&ngay_ket_thuc', 'YYYY-MM-DD');
    doanh_thu := tinh_tong_doanh_thu_khoang_thoi_gian(ngay_bat_dau, ngay_ket_thuc);
    DBMS_OUTPUT.PUT_LINE('Tong doanh thu tu ' || TO_DATE(ngay_bat_dau, 'YYYY-MM-DD') || ' den ' || TO_DATE(ngay_ket_thuc, 'YYYY-MM-DD') || ' la: ' || doanh_thu);
END;
---Kiem tra kh mua bao nhieu lan theo sdt
CREATE OR REPLACE FUNCTION dem_so_lan_mua(sdt_khach_hang IN KHACH_HANG.So_DT%TYPE)
RETURN NUMBER
AS
   so_lan_mua NUMBER;
BEGIN
   SELECT COUNT(Ma_Hoa_Don) into so_lan_mua
   FROM CHI_TIET_BAN_HANG CTBH join KHACH_HANG KH on CTBH.Ma_Khach_Hang = KH.Ma_Khach_Hang
   WHERE So_DT = sdt_khach_hang;

   RETURN so_lan_mua;
END;

SELECT dem_so_lan_mua('0123456789') FROM dual;
--kiem tra so luong nhan vien theo dia chi nhap vao
Create or replace function 
dem_qq (qq NHAN_VIEN.Ma_Nhan_Vien%type) 
Return number 
As 
   so number; 
Begin 
   select count (Ma_Nhan_Vien) into so From NHAN_VIEN Where Dia_chi=qq; 
   return so; 
End; 
Select dem_qq('&qq') from dual;


