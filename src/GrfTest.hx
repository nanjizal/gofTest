package;
import js.html.DivElement;
import tink.Url;
import nanjizal.tutorial.TutorialLoader;
class GrfTest{
    static function main(){ new GrfTest(); }
    static inline var _FONT = '</FONT>';
    static inline var FONT_ = '<FONT FACE="Trebuchet MS, Helvetica, sans-serif">';
    var tutorialsFolder = 'tutorials/';
    var tutorialsFile = 'tutorials.json';
    var tutorialLoader: TutorialLoader;
    var doc = js.Browser.window.document;
    var div: DivElement;
    var url: Url;
    function new(){
        div = doc.createDivElement();
        url = js.Browser.window.location.href;
        //js.Lib.alert( url.hash );
        loadTutorials();
    }
    function loadTutorials(){
        tutorialLoader = new TutorialLoader( tutorialsFolder, tutorialsFile, tutorialsLoaded );
        tutorialLoader.render = renderHtml;
    }
    function tutorialsLoaded(){
        var names = tutorialLoader.itemNames();
        var id = names.indexOf( url.hash );
        if( id == -1 ) id = 0;
        tutorialLoader.loadItemByName( names[ id ] );// load first blog item
    }
    function renderHtml( markdown: String ){
        div.innerHTML = FONT_ + markdown + _FONT;
        div.style.margin = '20px';
        doc.body.appendChild( div );
    }
}