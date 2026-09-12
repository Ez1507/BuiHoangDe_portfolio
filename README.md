# Bùi Hoàng Dể — Living Personal Profile

Website cá nhân có CMS quản trị riêng, dùng Supabase làm nơi lưu dữ liệu online và Supabase Storage để lưu ảnh.

## 1. Cấu trúc

- `index.html`: website + dashboard quản trị.
- `config.js`: Project URL + Publishable key của Supabase.
- `SUPABASE_SETUP.sql`: SQL tạo bảng, RLS và Storage bucket.
- `assets/`: ảnh gốc hiện có.

## 2. Cài Supabase

Project hiện tại:
`https://fvdnejhtunpitugbzbhs.supabase.co`

Trong Supabase → SQL Editor, chạy toàn bộ `SUPABASE_SETUP.sql` một lần. Script có thể chạy lại.

Tài khoản quản trị được giới hạn theo email:
`Hoangdeb751@gmail.com`

Tài khoản này phải tồn tại trong Authentication → Users.

## 3. Cách website hoạt động

- Website công khai đọc `portfolio_state`.
- Admin đăng nhập bằng Supabase Auth.
- Khi lưu nội dung, toàn bộ trạng thái portfolio được đồng bộ vào `portfolio_state`.
- Khi chọn ảnh từ máy, ảnh được upload vào bucket `portfolio-images`.
- Ảnh có thể bấm để xem bản đầy đủ.
- `localStorage` chỉ được dùng làm cache/fallback trên máy, không phải nguồn dữ liệu chính khi Supabase hoạt động.

## 4. Deploy Netlify

Upload toàn bộ thư mục chứa `index.html`, `config.js`, `assets/` và các file đi kèm lên Netlify.

Không thay đổi Publishable key bằng Secret/service_role key.

## 5. Sau khi deploy

Mở website → Quản trị → đăng nhập bằng tài khoản Supabase.

Thử:
1. Thêm một cột mốc.
2. Bấm Lưu.
3. Đăng xuất.
4. Tải lại website.
5. Nội dung vẫn còn vì đã được lưu trên Supabase.
6. Thử thêm ảnh trong Thư viện hoặc Thành tích để kiểm tra Storage.
