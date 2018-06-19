from flask import render_template, Flask, url_for, request, redirect
from app import app
import os
from werkzeug import secure_filename

UPLOAD_FOLDER = '/Volumes/Macintosh_HD/Users/zhengao/bio/ChIPSeq_4_6_2013/20150918/server/examples/my_scratch/app/templates/files/'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

@app.route('/', methods=['GET', 'POST'])
@app.route('/index', methods=['GET', 'POST'])
def index():
	error = None
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return redirect(url_for('uploaded_file',filename=filename))
            #return redirect(url_for('show_img', filename=uploaded_file(filename)))

    return render_template("index.html", error = error )

    '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form action="" method=post enctype=multipart/form-data>
      <p><input type=file name=file>
         <input type=submit value=Upload>
    </form>
    '''


'''
@app.route('/', methods=['GET', 'POST'])
@app.route('/index', methods=['GET', 'POST'])
def index():
	error = None
	if request.method == 'POST':
		#if form:
		#print form.get('input_logo_img', None)
		#fname_input_logo_img = form.get('input_logo_img', None)
		file = request.files['file']

        if file and allowed_file(file.filename):
        #if file and allowed_file(file):
			filename = secure_filename(file.filename)
			file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
			#return redirect(url_for('show_img', filename=filename))
			#return redirect(url_for('show_img', filename=uploaded_file(filename)))
			return redirect(url_for('uploaded_file',filename=filename))

	#return render_template("index.html", error = error )
	return ''''''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form action="" method=post enctype=multipart/form-data>
      <p><input type=file name=file>
         <input type=submit value=Upload>
    </form>
    '''


from flask import send_from_directory
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'],filename)




@app.route('/show_img', methods=['GET', 'POST'])
def show_img():
	error = None
	#if request.method == 'POST':
		
	return render_template("show_img.html", error = error, filename=filename)




# @app.route('/upload_files', methods=['GET', 'POST'])
# def upload_file():
#     if request.method == 'POST':
#         file = request.files['file']
#         if file and allowed_file(file.filename):
#             filename = secure_filename(file.filename)
#             file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
#             return redirect(url_for('uploaded_file',
#                                     filename=filename))
#     return '''
#     <!doctype html>
#     <title>Upload new File</title>
#     <h1>Upload new File</h1>
#     <form action="" method=post enctype=multipart/form-data>
#       <p><input type=file name=file, value ="{{request.form.input_logo_img}}">
#          <input type=submit value=Upload>
#     </form>
#     '''


