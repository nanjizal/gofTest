package nanjizal.tutorial;
import nanjizal.loaders.TxtLoader;
import haxe.Json;
using Markdown;
typedef Tutorials = {
    var tutorials:Array<Item>;
}
typedef Item = {
    var name: String;
    var content: Content;
}
typedef Content = {
    var links: Array<HtmlLink>;
    var markdown: String; 
}
typedef HtmlLink = {
    var name: String;
    var src: String;
}
class TutorialLoader{
    public var items: Array<Item>;
    public var currentItemsName: String;// name of item
    var names = new Array<String>();
    var tutorialsFolder: String;
    var txtLoader: TxtLoader;
    var tutorialsFile: String;
    var loaded: Void -> Void;
    public var render: String -> Void; // set how to render the markdown file loaded.
    public function itemNames(): Array<String> {
        if( names.length == 0 ) for( item in items ) names.push( item.name );
        return names;
    }
    public function loadItemByName( name: String ){
        var index = names.indexOf( name );
        var itemContent = items[ index ].content;
        var currentItem = itemContent.markdown;
        var links       = itemContent.links;
        txtLoader.reload( [ tutorialsFolder + currentItem ], renderMarkDown.bind( currentItem, name, links ) );
    }
    public function new( tutorialsFolder_: String, tutorialsFile_: String, loaded_: Void->Void ){
        tutorialsFolder = tutorialsFolder_;
        tutorialsFile = tutorialsFile_;
        loaded = loaded_;
        txtLoader = new TxtLoader( [ tutorialsFolder + 'tutorials.json'], jsonsLoaded );
    }
    function jsonsLoaded(){
        var tutorialsJson: Tutorials = Json.parse( txtLoader.contents.get( 'tutorials.json' ) );
        items = tutorialsJson.tutorials;
        loaded();
    }
    function renderMarkDown( currentItem: String, name: String, links: Array<HtmlLink> ){
        currentItemsName = name;
        var str = txtLoader.contents.get( currentItem );
        for( link in links ) str = StringTools.replace( str, '$' + link.name, link.src ); // add any links in file
        if( render != null ) render( str.markdownToHtml() );
    }
}