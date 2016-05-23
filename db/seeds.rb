# encoding: UTF-8

admin = User::Create.(user: { firstname: "CJ", lastname: "Kühn", email: "info@cj-agency.de", phone: "0123456789", gender: "f", password: "Test1234", confirm_password: "Test1234" }).model

