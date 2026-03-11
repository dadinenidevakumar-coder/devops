from flask import Flask
app = Flask(name)
@app.route('/') def home(): return "Hello from Docker Web App!"
if name == "main": app.run(host"0.0.0.0", port=5000)

