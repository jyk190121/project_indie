<!DOCTYPE html> 
<html lang ="en">
    <head>
        <meta charset="UTF-8" >
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Croppie - a simple javascript image cropper - Foliotek</title>

        <meta name="description" content="Croppie is an easy to use javascript image cropper.">

        <meta property="og:title" content="Croppie - a javascript image cropper">
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://foliotek.github.io/Croppie">
        <meta property="og:description" content="Croppie is an easy to use javascript image cropper.">
        <meta property="og:image" content="https://foliotek.github.io/Croppie/demo/hero.png">

        <link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600,700' rel='stylesheet' type='text/css'>
        <link rel="Stylesheet" type="text/css" href="/public/croppie/prism.css" />
        <link rel="Stylesheet" type="text/css" href="/public/croppie/bower_components/sweetalert/dist/sweetalert.css" />
        <link rel="Stylesheet" type="text/css" href="/public/croppie/croppie.css" />
        <link rel="Stylesheet" type="text/css" href="/public/croppie/demo/demo.css" />
        <link rel="icon" href="//foliotek.github.io/favico-64.png" />
    </head>
    <body>
        <section>
            <a id="demos" name="demos"></a>
            <div class="section-header">
                <h2>Demos</h2>
            </div>
            <div class="demo-wrap">
                <div class="container">
                    <div class="grid">
                        <div class="col-1-2">
                            <strong>Basic Example</strong>
                          <pre class="language-javascript"><code class="language-javascript">
var basic = $('#demo-basic').croppie({
    viewport: {
        width: 150,
        height: 200
    }
});
basic.croppie('bind', {
    url: 'demo/cat.jpg',
    points: [77,469,280,739]
});
//on button click
basic.croppie('result', 'html').then(function(html) {
    // html is div (overflow hidden)
    // with img positioned inside.
});</code></pre>
                          <div class="actions">
                              <button class="basic-result">Result</button>
                              <input type="number" class="basic-width" placeholder="width" /> x <input type="number" class="basic-height" placeholder="height" />
                          </div>
                        </div>
                        <div class="col-1-2">
                            <div id="demo-basic"></div>
                        </div>
                    </div>
                </div>
            </div>
                <div class="demo-wrap">
                    <div class="container">
                        <div class="grid">
                            <div class="col-1-2">
                                <div id="vanilla-demo"></div>
                            </div>
                            <div class="col-1-2">
                                <strong>Vanilla Example</strong>
                                <pre class="language-javascript"><code class="language-javascript">
var el = document.getElementById('vanilla-demo');
var vanilla = new Croppie(el, {
    viewport: { width: 100, height: 100 },
    boundary: { width: 300, height: 300 },
    showZoomer: false,
    enableOrientation: true
});
vanilla.bind({
    url: 'demo/demo-2.jpg',
    orientation: 4
});
//on button click
vanilla.result('blob').then(function(blob) {
    // do something with cropped blob
});</code></pre>
                                <div class="actions">
                                    <button class="vanilla-result">Result</button>
                                    <button class="vanilla-rotate" data-deg="-90">Rotate Left</button>
                                    <button class="vanilla-rotate" data-deg="90">Rotate Right</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="demo-wrap">
                    <div class="container">
                        <div class="grid">
                            <div class="col-1-2">
                                <strong>Resizer Example</strong>
                                <pre class="language-javascript"><code class="language-javascript">
var el = document.getElementById('resizer-demo');
var resize = new Croppie(el, {
    viewport: { width: 100, height: 100 },
    boundary: { width: 300, height: 300 },
    showZoomer: false,
    enableResize: true,
    enableOrientation: true,
    mouseWheelZoom: 'ctrl'
});
resize.bind({
    url: 'demo/demo-2.jpg',
});
//on button click
resize.result('blob').then(function(blob) {
    // do something with cropped blob
});</code></pre>
                                <div class="actions">
                                    <button class="resizer-result">Result</button>
                                </div>
                            </div>
                            <div class="col-1-2">
                                <div id="resizer-demo"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="demo-wrap upload-demo">
                    <div class="container">
                    <div class="grid">
                        <div class="col-1-2">
                            <strong>Upload Example (with exif orientation compatability)</strong>
                            <pre class="language-javascript"><code class="language-javascript">
$uploadCrop = $('#upload-demo').croppie({
    enableExif: true,
    viewport: {
        width: 200,
        height: 200,
        type: 'circle'
    },
    boundary: {
        width: 300,
        height: 300
    }
});</code></pre>
                            <div class="actions">
                                <a class="btn file-btn">
                                    <span>Upload</span>
                                    <input type="file" id="upload" value="Choose a file" accept="image/*" />
                                </a>
                                <button class="upload-result">Result</button>
                            </div>
                        </div>
                        <div class="col-1-2">
                            <div class="upload-msg">
                                Upload a file to start cropping
                            </div>
                            <div class="upload-demo-wrap">
                                <div id="upload-demo"></div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <div class="demo-wrap hidden-demo">
                    <div class="container">
                    <div class="grid">
                        <div class="col-1-2">
                            <strong>Hidden Example</strong>
                            <p>When binding a croppie element that isn't visible, i.e., in a modal - you'll need to call bind again on your croppie element, to indicate to croppie that the position has changed and it needs to recalculate its points.</p>

                            <pre class="language-javascript"><code class="language-javascript">
$('#hidden-demo').croppie('bind')</code></pre>
                            <div class="actions">
                                <button class="show-hidden">Toggle Croppie</button>
                            </div>
                        </div>
                        <div class="col-1-2">
                            <div id="hidden-demo" style="display: none;"></div>
                        </div>
                    </div>
                    </div>
                </div>
        </section>

        <footer>
           	<span id="year">2017</span>
        </footer>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="/public/croppie/bower_components/jquery/dist/jquery.min.js"><\/script>')</script>
        <script src="/public/croppie/demo/prism.js"></script>
        <script src="/public/croppie/bower_components/sweetalert/dist/sweetalert.min.js"></script>

        <script src="/public/croppie/croppie.js"></script>
        <script src="/public/croppie/demo/demo.js"></script>
        <script src="/public/croppie/bower_components/exif-js/exif.js"></script>
        <script>
            document.getElementById('year').innerHTML = (new Date).getFullYear();
            Demo.init();
        </script>
        <script>
            (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
            function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
            e=o.createElement(i);r=o.getElementsByTagName(i)[0];
            e.src='//www.google-analytics.com/analytics.js';
            r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
            ga('create','UA-2398527-4');ga('send','pageview');
        </script>
        <a href="https://github.com/foliotek/croppie" class="github-corner"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#151513; color:#fff; position: absolute; top: 0; border: 0; left: 0; transform: scale(-1, 1); -webkit-transform: sale(-1, 1);"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style></a>
    </body>
</html>