# limitations under the License.                                                                                                      
from __future__ import print_function
# [START gae_flex_websockets_app]                                                                                                     
from flask import Flask, render_template, request
app = Flask(__name__)

@app.route('/')
def index():
    return render_template('lflogin.html')
    
@app.route('/browsing.html')
def browsing():
    return render_template('browsing.html')
    
@app.route('/lfsubmitlostitem.html')
def submit():
    return render_template('lfsubmitlostitem.html')
    
@app.route('/lfaboutUs.html')
def about():
    return render_template('lfaboutUs.html')
    
@app.route('/submit', methods = ['POST', 'GET'])
def submitInfo():
    if request.method == 'POST':
        content = request.get_json()
        print(content)
        return "success" #placeholder return value
        
@app.route('/search', methods = ['POST', 'GET'])
def browsingSearch():
    if request.method == 'POST':
        content = request.get_json()
        print(content)
        return "success" #placeholder return value
    
if __name__ == "__main__":
    app.run(threaded=True, port=80)