server {
    listen 80;
    listen [::]:80;

    server_name tasks1.ovmwan.com;

    location / {
        proxy_pass http://localhost:4794;
    }

    location /socket {
        proxy_pass http://localhost:4794;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
