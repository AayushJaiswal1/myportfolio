# Step 1: Use the official Nginx image as a base
FROM nginx:latest

# Step 2: Copy your website files to the default Nginx web directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Step 3: Copy the custom Nginx configuration file
COPY nginx-conf/default.conf /etc/nginx/conf.d/default.conf

# Step 4: Expose port 80 for HTTP traffic
EXPOSE 80

# Step 5: Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]

