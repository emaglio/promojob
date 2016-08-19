require 'pony'

Pony.options = {
  from: "info@cj-agency.de",
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