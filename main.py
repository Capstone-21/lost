# limitations under the License.                                                                                                      
from __future__ import print_function
# [START gae_flex_websockets_app]                                                                                                     
from flask import Flask, render_template
from flask_sockets import Sockets
app = Flask(__name__)
sockets = Sockets(app)

@app.route('/')
def index():
    return render_template('lflogin.html')
    
 if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)