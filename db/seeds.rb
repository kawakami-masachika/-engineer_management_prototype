# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Employee.create(employee_id: 'ST001',last_name:'テスト名', first_name: 'テスト姓', kana_last_name: 'テストメイ', kana_first_name: 'テストセイ', birth_date: '20000102', join_date: '20191101',experience: '2年3ヶ月',line: '都営地下鉄三田線', station: '板橋区役所前',mst_employee_type_id:1, data_status: 1, employee_icon: '', age: 25, mst_gender_id: 1)