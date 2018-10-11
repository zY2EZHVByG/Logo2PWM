from flask import render_template, Flask, url_for, request, redirect
from app import app
import os
from werkzeug import secure_filename
import mechanize
import time
import platform
from random import randint
#import pwm2logo 

# need to change UPLOAD_FOLDER and exe_path when run on a new platform.
if platform.platform()[0:6] == 'Darwin': # if my macbook
    Main_Path = '/Users/zhengao/Dropbox/bio/'+\
        'ChIPSeq_4_6_2013/20150918/'
    UPLOAD_FOLDER = Main_Path+ 'my_scratch/'+\
        'app/templates/files/'
    exe_path = Main_Path+\
            "f_logo_to_PWM_publish"
elif platform.platform()[0:6] == 'Window': # if my desktop
    Main_Path = 'C:/Users/zhen/Desktop/20150918/'
    UPLOAD_FOLDER = Main_Path + 'my_scratch/'+\
        'app/templates/files/'
    exe_path = Main_Path + 'f_logo_to_PWM_publish.exe '

    #else if CBI linux
elif platform.platform()[0:6] == 'Linux-':
    Main_Path = '/home/zhen.gao/bio/ChIPSeq_4_6_2013/20150918/'
    UPLOAD_FOLDER = Main_Path+ 'my_scratch/'+ 'app/templates/files/'
    exe_path = Main_Path + \
        'run_f_logo_to_PWM_publish.sh  /share/apps/MATLAB/R2014b '

# allowed file extensions
ALLOWED_EXTENSIONS = set(['png','PNG', 'jpg','JPG', 'jpeg','JPEG', 'gif','GIF'])

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# initialize some variables
filename = '123'
fn_txt_pure = ''
fn_csv_pure = ''
fn_txt_pure_meme_pssm = ''
logo_url_pdf = ''
logo_url_png = ''
fn_rg_logo_png = ''

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

def more_secure_name(fn1):
    '''
    delete odd chars in string, 
    make the file name more secure
    '''
    fn1 = secure_filename(fn1)
    [main, ext] = os.path.splitext(fn1)
    main = main.translate(None, ' -_.!@#$')
    main = main + '_' + str(randint(0, 999))
    #print main
    return main + ext


# index page
@app.route('/', methods=['GET', 'POST'])
@app.route('/index', methods=['GET', 'POST'])
def index():
    error = None
    # if received a POST request
    if request.method == 'POST':
        file = request.files['file']
        # if the file is legal
        if file and allowed_file(file.filename):
            global filename

            filename = more_secure_name(file.filename)
            print filename
            # save the file to server
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            #return redirect(url_for('uploaded_file',filename=filename))
            #return redirect(url_for('show_img', filename=uploaded_file(filename)))
            print filename
            # go to 'show_img' page
            return redirect(url_for('show_img'))
    # else stay in index
    return render_template("index.html", error = error )

    # '''
    # <!doctype html>
    # <title>Upload new File</title>
    # <h1>Upload new File</h1>
    # <form action="" method=post enctype=multipart/form-data>
    #   <p><input type=file name=file>
    #      <input type=submit value=Upload>
    # </form>
    # '''



from flask import send_from_directory
# show a file in the /uploads folder
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'],filename)


def ger_enologo_url(fn):
    '''
    input a text file name, submit its content to enologo website, 
    the website will generate the logo, then we get the logo url.
    '''
    # read the matrix file into a string
    # target my generated reverse-engineering matrix for enologo
    # read the text file as a string
    with open (fn, "r") as myfile:
        data=myfile.read()
    
    # start the mechanize browser
    #url = "http://lagavulin.ccbb.pitt.edu/cgi-bin/enologos/enologos.cgi"
    url = "http://www.benoslab.pitt.edu/cgi-bin/enologos/enologos.cgi"
    br = mechanize.Browser()
    br.set_handle_robots(False) # ignore robots
    br.open(url)
    # choose a form to interact with
    br.select_form(nr=0)

    # choose DNA default option
    # submit the web and then we can actually run it
    #time.sleep(1) # delays for x seconds
    br["#reset_form"] = ["1"]
    res = br.submit()
    
    time.sleep(0.5) # delays for x seconds
    
    # submit the matrix
    br.select_form(nr=0)
    br["matrix"] = data
    res = br.submit()

    #download_url = 'http://lagavulin.ccbb.pitt.edu/enologos/tmp/'
    download_url = 'http://www.benoslab.pitt.edu/enologos/tmp/'
    # find the link to the image
    code_str = ''
    for link in br.links():
        #print link.text
        #print '   '
        if link.text[:3] == 'PDF':
            #print link.text, link.url
        
            print link.url, link.url[42:]
            #ix = link.url[44:].index('.')
            ix = link.url[42:].index('.')
            
            #print link.url[42:][:ix]
            code_str = link.url[42:][:ix]
    # return the image url, without the extension,
    return download_url+code_str



@app.route('/show_img', methods=['GET', 'POST'])
def show_img():
    error = None
    # if the user click the submit button
    if request.method == 'POST':
        letter_cols = request.form['letter_cols']
        # run the executable Matlab code 
        print exe_path+app.config['UPLOAD_FOLDER']+filename+' '+letter_cols
        print os.popen(exe_path + \
            app.config['UPLOAD_FOLDER']+filename+' '+letter_cols).read()
        # now the matrix txt file has been generated, 
        # submit it to enologo.
        #fname = app.config['UPLOAD_FOLDER']+filename

        # save the image file and text file from enologo website 
        #  to the server, within the same directory of the logo.
        fn_prefix = filename.split('.')[0]
        global fn_txt_pure
        global fn_csv_pure
        global fn_txt_pure_meme_pssm
        global logo_url_pdf
        global logo_url_png
        global fn_rg_logo_png

        fn_txt_pure = fn_prefix + '_enoLogo.txt'
        fn_csv_pure = fn_prefix + '.csv'
        fn_txt_pure_meme_pssm = fn_prefix + '_meme_pssm.txt'
        fn_txt = app.config['UPLOAD_FOLDER'] + fn_txt_pure


        logo_url = ger_enologo_url(fn_txt)
        logo_url_pdf = logo_url + '.pdf'
        #logo_url_png = fn_prefix + '_rg_logo.png'
        logo_url_png = logo_url + '.png'
        print logo_url_png
        print logo_url_pdf
        fn_rg_logo_png = fn_prefix + '_rg_logo.png'
        url_enologo_matrices = logo_url + '.logo_log'
        #pwm2logo.f_draw_logo_from_pwm(app.config['UPLOAD_FOLDER'] + fn_csv_pure)
        

        print "hehe"
        return redirect(url_for('sh_res'))
        return render_template("sh_res.html", error=error, \
            img_logo=url_for('uploaded_file', filename=filename), \
            pwm_txt=url_for('uploaded_file', filename=fn_txt_pure), \
            pwm_csv=url_for('uploaded_file', filename=fn_csv_pure), \
            meme_pssm_txt=url_for('uploaded_file', filename=fn_txt_pure_meme_pssm), \
            enologo_regen=logo_url_png, \
            logo_pdf=logo_url_pdf )
            #enologo_regen=url_for('uploaded_file', filename=fn_rg_logo_png) )

    
    print filename
    return render_template("show_img.html", error = error, \
        img_logo=url_for('uploaded_file', filename=filename) ) 


@app.route('/sh_res', methods=['GET', 'POST'])
def sh_res():
    error = None
    #if request.method == 'POST':
    return render_template("sh_res.html", error=error, \
        img_logo=url_for('uploaded_file', filename=filename), \
        pwm_txt=url_for('uploaded_file', filename=fn_txt_pure), \
        pwm_csv=url_for('uploaded_file', filename=fn_csv_pure), \
        meme_pssm_txt=url_for('uploaded_file', filename=fn_txt_pure_meme_pssm), \
        enologo_regen=logo_url_png, \
        logo_pdf=logo_url_pdf )
        #enologo_regen=url_for('uploaded_file', filename=fn_rg_logo_png) )


# download_source page
@app.route('/', methods=['GET', 'POST'])
@app.route('/download_source', methods=['GET', 'POST'])
def download_source():
    error = None
    #if request.method == 'POST':
    return render_template("download_source.html", error=error  )


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


