require 'pony'

Pony.options = {
  from: "emanuele.magliozzi@gmail.com",
  via: :smtp, 
  via_options: {address: "smtp.gmail.com", 
                port: "587",
                domain: 'localhost:3000', 
                enable_starttls_auto: true, 
                # ssl: true, 
                user_name: "emanuele.magliozzi@gmail.com", 
                password: "password", 
                authentication: :login} 
}