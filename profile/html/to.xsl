<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs" version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6
            http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed: 1. Distributed under a Creative Commons
            Attribution-ShareAlike 3.0 Unported License
            http://creativecommons.org/licenses/by-sa/3.0/ 2.
            http://www.opensource.org/licenses/BSD-2-Clause Redistribution and use in source and
            binary forms, with or without modification, are permitted provided that the following
            conditions are met: * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer. * Redistributions in
            binary form must reproduce the above copyright notice, this list of conditions and the
            following disclaimer in the documentation and/or other materials provided with the
            distribution. This software is provided by the copyright holders and contributors "as
            is" and any express or implied warranties, including, but not limited to, the implied
            warranties of merchantability and fitness for a particular purpose are disclaimed. In no
            event shall the copyright holder or contributors be liable for any direct, indirect,
            incidental, special, exemplary, or consequential damages (including, but not limited to,
            procurement of substitute goods or services; loss of use, data, or profits; or business
            interruption) however caused and on any theory of liability, whether in contract, strict
            liability, or tort (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage. </p>
         <p>Andrej Pan??ur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>

   <xsl:param name="homeLabel">Domov</xsl:param>
   <xsl:param name="homeURL">https://sistory.github.io/ljsubkultmediji/index.html</xsl:param>

   <xsl:param name="splitLevel">1</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>

   <!--
   <xsl:param name="languages-locale">true</xsl:param>
   <xsl:param name="languages-locale-primary">en</xsl:param>-->

   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"/>
   <xsl:param name="numberFrontTables"/>
   <xsl:param name="numberHeadings"/>
   <xsl:param name="numberParagraphs"/>
   <xsl:param name="numberTables"/>

   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Paralelne zgodovine opolnomo??enja in urbanosti Slovenije
      1980???1990???2000 / Parallel Histories of Slovenia's Empowerment and Urbanity
      1980-1990-2000</xsl:param>
   <xsl:param name="keywords">SKUC, Ljubljana, zbirka</xsl:param>
   <xsl:param name="title">Paralelne zgodovine opolnomo??enja in urbanosti Slovenije
      1980???1990???2000</xsl:param>

   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc/>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of
            select="concat($path-general, 'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css"
         rel="stylesheet" type="text/css"/>
      <link
         href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}"
         rel="stylesheet" type="text/css"/>
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodam projektno specifi??en css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"/>
      <!-- za highcharts -->
      <xsl:if
         test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile"
            select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"/>
      </xsl:if>
      <!-- za back-to-top in highcharts je druga??e potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je ??e vsebovana zgoraj -->
      <!-- dodan css jstree (mora biti za jquery.js -->
      <link
         href="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}"
         rel="stylesheet" type="text/css"/>
      <!-- dodan jstree -->
      <script src="{concat($path-general,'themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Container za poglavja</desc>
   </doc>
   <xsl:template match="tei:div[@type = 'documents']">
      <div class="accordion" data-accordion="" data-allow-all-closed="true">
         <xsl:for-each select="tei:div[@type = 'closed']">
            <div class="accordion-item" data-accordion-item="">
               <a href="#" class="accordion-title">
                  <h5>
                     <xsl:value-of select="tei:head"/>
                  </h5>
               </a>
               <div class="accordion-content" data-tab-content="">
                  <xsl:apply-templates/>
               </div>
            </div>
         </xsl:for-each>
         <xsl:for-each select="tei:div[@type = 'active']">
            <div class="accordion-item is-active" data-accordion-item="">
               <a href="#" class="accordion-title">
                  <h5>
                     <xsl:value-of select="tei:head"/>
                  </h5>
               </a>
               <div class="accordion-content" data-tab-content="">
                  <xsl:apply-templates/>
               </div>
            </div>
         </xsl:for-each>
      </div>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Container za podpoglavja/seznam</desc>
   </doc>
   <xsl:template match="tei:listBibl[@type = 'reartikulacija']">
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <xsl:for-each select="tei:biblFull">
            <li class="accordion-item" data-accordion-item="">
               <a href="#" class="accordion-title">
                  <xsl:value-of select="tei:titleStmt/tei:title"/>
               </a>
               <div class="accordion-content" data-tab-content="">
                  <xsl:apply-templates/>
               </div>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Container za filme</desc>
   </doc>
   <xsl:template match="tei:figure[@type = 'video']">
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <div class="accordion-item" data-accordion-item="">
            <a href="#" class="accordion-title">
               <xsl:value-of select="tei:head"/>
            </a>
            <div class="accordion-content" data-tab-content="">
               <xsl:apply-templates/>
            </div>
         </div>
      </ul>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
   </doc>
   <xsl:template match="tei:figure[@type = 'PDF']">
      <embed src="{tei:graphic/@url}" type="application/pdf" height="1400" width="100%"/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>??lanki</desc>
   </doc>
   <xsl:template match="tei:listBibl[@type = 'clanki']">
      <ul class="accordion" data-accordion="" data-allow-all-closed="true">
         <xsl:for-each select="tei:bibl">
            <li class="accordion-item" data-accordion-item="">
               <a href="#" class="accordion-title">
                  <xsl:value-of select="tei:title[@type = 'main']"/>
               </a>
               <div class="accordion-content" data-tab-content="">
                  <xsl:for-each select="tei:title[@type = 'sub']">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Naslov:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:author">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Avtor:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:date">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Datum:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="@when"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:idno">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Vir:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="."/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <hr/>
                  <embed src="{tei:ref/@target}" type="application/pdf" height="600" width="100%"/>
               </div>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Katalog - ocr</desc>
   </doc>
   <xsl:template match="tei:listBibl[@type = 'appendix']">
      <ul class="accordion" data-accordion="" data-allow-all-closed="true" data-deep-link="true"
         data-update-history="true" data-deep-link-smudge="true" data-deep-link-smudge-delay="500"
         id="deeplinked-accordion">
         <xsl:for-each select="tei:bibl">
            <li class="accordion-item is-active" data-accordion-item="">
               <a href="{@xml:id}" class="accordion-title">
                  <xsl:value-of select="tei:title"/>
               </a>
               <div class="accordion-content" data-tab-content="" id="{@xml:id}">
                  <xsl:for-each select="tei:title">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Naslov:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:author">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Avtor:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="normalize-space(.)"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:date">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Datum:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="@when"/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <xsl:for-each select="tei:idno">
                     <div
                        style="line-height: 25px; margin-bottom: 3px; display: flex; flex-direction: row;"
                        id="{@xml:id}">
                        <div style="width: 200px;">Vir:</div>
                        <div style="flex: 1;">
                           <xsl:value-of select="."/>
                        </div>
                     </div>
                  </xsl:for-each>
                  <hr/>
                  <embed src="{tei:ref/@target}" type="application/pdf" height="600" width="100%"/>
               </div>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za kolofon</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-colophon-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>O projektu</xsl:text>
   </xsl:template>

   <!--
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za front front/div</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-front-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Sklopi</xsl:text>
   </xsl:template>-->


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Sklopi</xsl:text>
   </xsl:template>


   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>K naslovni strani dam dodatno vsebino, ki ni procesirana iz TEI</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template match="tei:titlePage">
      <!-- naslov -->
      <xsl:for-each select="tei:docTitle/tei:titlePart[1]">
         <h1 class="text-center">
            <xsl:value-of select="."/>
         </h1>
         <xsl:for-each select="following-sibling::tei:titlePart">
            <h1 class="subheader podnaslov">
               <xsl:value-of select="."/>
            </h1>
         </xsl:for-each>
      </xsl:for-each>
      <p class="naslovnicaAvtor">
         <xsl:for-each select="tei:docAuthor">
            <xsl:choose>
               <xsl:when test="tei:forename or tei:surname">
                  <xsl:for-each select="tei:forename">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:if test="tei:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:for-each select="tei:surname">
                     <xsl:value-of select="."/>
                     <xsl:if test="position() ne last()">
                        <xsl:text> </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="position() ne last()">
               <br/>
            </xsl:if>
         </xsl:for-each>
      </p>
      <br/>
      <figure>
         <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
         <!--<figcaption style="font-size: 70%;">naslov slike</figcaption>-->
      </figure>
      <br/>

      <div class="row">
         <div class="small-12 columns">
            <div class="callout secondary" data-closable="">
               <p style="text-align:justify">Ta celoten pregled sem pripravila na na??in genealogije,
                  torej na na??in zavzete, situirane in vizijsko zastavljene zgodovine, ki se razvija
                  v ??asu. ??as, ki ga zajema, je obdobje prej??njega stoletja, ki se za??ne leta 1978
                  pa vse do novega tiso??letja. V tem ??asu zaznavamo produkcijo v polju umetnosti, kulture,
                  tehnologije in dru??benega, ki je nenadoma in za vselej celoten prostor in ??e
                  posebej Ljubljano spremenila iz nepomembne vasi v zavzeto mesto z odprtim pogledom
                  v prihodnost. Vse, kar se je vzpostavilo v teh dekadah, je pustilo pe??at:
                  urbanost, za????ita ??lovekovih pravic, coming out LGBTQI+ skupnosti,
                  antimilitaristi??ni pogled na svet ter pogled na tehnologijo kot odprto kodo in
                  nenazadnje vizija pomena antikolonialnih in antikapitalisti??nih bojev. Vse to
                  omogo??a Sloveniji, da v novem tiso??letju ??e enkrat izbere prihodnost.</p>
               <p style="text-align:justify">Naslov pove??e alternativno ali subkulturno sceno v
                  Ljubljani v osemdesetih, ??as, ko Ljubljana ni glavno mesto Slovenije temve?? glavno
                  mesto Socialisti??ne republike Slovenije v sestavi nekdanje Jugoslavije in
                  medijskega sveta, ki je danes pre??et z dru??benimi platformami, intermedijskimi
                  povezavami, mobilno telefonijo in digitalno virtualno realnostjo sveta, torej tudi
                  prostor, ki je ve?? kot le Slovenija. Subkulturna oziroma alternativna scena
                  Ljubljane v tistem ??asu, njena progresivna politi??na, kulturna in dru??bena dr??a v
                  javnem socialisti??nem ??ivljenju, je v osemdesetih letih postavila Ljubljano na
                  zemljevid urbanih naprednih sredi????. Po punkovski revoluciji (od leta 1977 do
                  tranzicije v postpunkovski svet v osemdesetih) je leta 1984 sledil coming out, ta
                  veliki preboj LGBT skupnosti na plano, z organizacijo prvega javnega Magnus
                  festivala z naslovom ??Homoseksualnost in kultura?? v Galeriji ??KUC.</p>
               <hr style="border-top: dotted 2px;"></hr>
               <p style="text-align:justify">I have written this general overview in the manner of a
                  genealogy, that is, in the manner of an eventful, situational and visionary
                  history that evolves with time. The period it covers is the period of the last
                  century, starting in 1978 and ending in the new millennium, when we witness the production in
                  the fields of art, culture, technology and the social that suddenly and forever
                  changed the entire space, and Ljubljana in particular, from an insignificant
                  village to an urban place with its eyes open to the future. Everything that was
                  built during these decades has left its mark: Urbanity, the protection of human
                  rights, the coming out of LGBTQI+ communities, the anti-militarist worldview and
                  the conception of technology as open source, and last but not least, the vision of
                  anti-colonial and anti-capitalist struggles. In the new millennium, all this
                  enables Slovenia to choose its own future anew.</p>
               <p style="text-align:justify">The title makes a connection between the alternative or
                  subcultural scene in Ljubljana in the 1980s, a time when Ljubljana was not the
                  capital of Slovenia but the capital of the Socialist Republic of Slovenia as part
                  of the former Yugoslavia, and the media world that today is permeated by social
                  platforms, the intermedia world that is also a space that is more than just
                  Slovenia. The subcultural or alternative scene of Ljubljana at that time, its
                  progressive political, cultural and social stance in public socialist life, put
                  Ljubljana on the map of progressive urban centers in the 1980s. The punk
                  revolution (from 1977 to the transition to the post-punk world in the 1980s) was
                  followed in 1984 by the coming out of homosexuals, this major breakthrough of the
                  LGBT community, with the organization of the first public Magnus Festival under
                  the title "Homosexuality and Culture" at the ??KUC Gallery.</p>
            </div>
         </div>
      </div>


      <div class="row border-content">
         <div class="medium-6 columns border-content-inner">
            <h4>Sklopi:</h4>
            <ul class="toc toc_front">
               <xsl:for-each select="//tei:body/tei:div"><li class="toc">
                  <a>
                     <xsl:attribute name="href">
                        <xsl:apply-templates mode="generateLink" select="."/>
                     </xsl:attribute>
                     <xsl:for-each select="tei:head">
                        <xsl:apply-templates select="." mode="chapters-head"/>
                        <xsl:if test="position() != last()">
                           <xsl:text> / </xsl:text><br></br>
                        </xsl:if>
                     </xsl:for-each>                    
                  </a>
               </li>
               </xsl:for-each>
            </ul>
            <!--<div class="callout secondary" data-closable="" style="font-size: 70%;">
               <p>glej: <a href="#">LINK</a></p>
               <button class="close-button" aria-label="Dismiss alert" type="button" data-close="" style="background-color: inherit;">
                  <span aria-hidden="true">&#xD7;</span>
               </button>
            </div>-->
         </div>
         <div class="medium-6 columns border-content-inner">
            <h4>Katalog ??KUC</h4>
            <ul class="accordion" data-accordion="" data-allow-all-closed="true">
               <li class="accordion-item is-active" data-accordion-item="">
                  <a href="#" class="accordion-title">Galerija ??kuc Ljubljana 1978-1987 / The ??KUC
                     Gallery 1978-1987</a>
                  <div class="accordion-content" data-tab-content="">
                     <embed
                        src="https://www2.sistory.si/publikacije/razstave/SKUC/SKUC_katalog.pdf"
                        type="application/pdf" height="600" width="100%"/>
                  </div>
               </li>
            </ul>
         </div>
      </div>
      <div>
         <h3>Kolofon</h3>
         <p>Zbirko gradiva je sestavila Marina Gr??ini??</p>
         <p>Avtorica spremnih tekstov: Marina Gr??ini??</p>
         <p>Asistentka Marini Gr??ini?? pri pripravi materiala: Jovita Pristov??ek</p>
         <p>Pregled in urejanje zbirke: Ana Cvek, Karin Konda</p>
         <p>Digitalizacija: Ur??ka Svetina, Karin Konda</p>
         <p>Spletna zasnova in tehni??na izvedba: Mihael Ojster??ek</p>
         <p>Ljubljana, 2022</p>
      </div>

      <!--<div class="row border-content">
         <div class="small-12 columns border-content-inner">
            <h4>Gradivo:</h4>
            <div class="row" id="treeview-container">
               <ul>
                  <xsl:for-each select="//tei:body/tei:div[@type][@xml:id]">
                     <xsl:call-template name="TOC-title-type-li"/>
                  </xsl:for-each>
               </ul>
               <script type="text/javascript">
                        $('#treeview-container').jstree().bind("select_node.jstree", function (e, data) {
                            var href = data.node.a_attr.href;
                            document.location.href = href;
                        });</script>
               <br/>
               <br/>
               <br/>
            </div>
         </div>
      </div>-->
      <br/>
      <br/>
      <br/>
      <br/>
      <br/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Povozim privzeto procesiranje kolofona iz teiHeader</desc>
   </doc>
   <xsl:template
      match="tei:TEI/tei:teiHeader/tei:fileDesc | tei:teiCorpus/tei:teiHeader/tei:fileDesc"
      mode="kolofon">
      <ul class="accordion" data-accordion="" data-multi-expand="true">
         <li class="accordion-item" data-accordion-item="">
            <!-- naslov -->
            <a href="#" class="accordion-title">Parallel Histories of Slovenia's Empowerment and
               Urbanity 1980-1990-2000</a>
            <!-- vsebina -->
            <div class="accordion-content" data-tab-content="">
               <h3 style="text-align:center;">Parallel Histories of Slovenia's Empowerment and
                  Urbanity 1980-1990-2000</h3>
               <h4 style="text-align:center;">From the Ljubljana Subcultural Scene to the New Media
                  Scene in Slovenia</h4>
               <docAuthor>
                  <h3 style="text-align:center;">Marina Gr??ini??</h3>
               </docAuthor>
               <p style="text-align:justify;">I have written this general overview in the manner of
                  a genealogy, that is, in the manner of an eventful, situational and visionary
                  history that evolves with time. The period it covers is the period of the last
                  century, starting in 1978 and ending in the new millennium, when we witness the production in
                  the fields of art, culture, technology and the social that suddenly and forever
                  changed the entire space, and Ljubljana in particular, from an insignificant
                  village to an urban place with its eyes open to the future. Everything that was
                  built during these decades has left its mark: Urbanity, the protection of human
                  rights, the coming out of LGBTQI+ communities, the anti-militarist worldview and
                  the conception of technology as open source, and last but not least, the vision of
                  anti-colonial and anti-capitalist struggles. In the new millennium, all this
                  enables Slovenia to choose its own future anew.</p>
               <p style="text-align:justify;">The title makes a connection between the alternative
                  or subcultural scene in Ljubljana in the 1980s, a time when Ljubljana was not the
                  capital of Slovenia but the capital of the Socialist Republic of Slovenia as part
                  of the former Yugoslavia, and the media world that today is permeated by social
                  platforms, the intermedia world that is also a space that is more than just
                  Slovenia. The subcultural or alternative scene of Ljubljana at that time, its
                  progressive political, cultural and social stance in public socialist life, put
                  Ljubljana on the map of progressive urban centers in the 1980s. The punk
                  revolution (from 1977 to the transition to the post-punk world in the 1980s) was
                  followed in 1984 by the coming out of homosexuals, this major breakthrough of the
                  LGBT community, with the organization of the first public Magnus Festival under
                  the title "Homosexuality and Culture" at the ??KUC Gallery.</p>
               <p style="text-align:justify;">At the same time, these big events, punk and
                  "homosexuality and culture," video subculture, visual culture, punk and post-punk
                  images, marked a social and political upheaval of the idea of youth and sexuality.
                  But it was not a coup or a desire to destroy socialism, but a determination to
                  continue it step by step, precisely in that utopian dimension that manifested
                  itself in the realm of rhetoric. For the socialism of self-management, pressured
                  by real socialism (which was Stalinist in color), promised, if nothing else,
                  equality and opportunity for all, the possibility of building a future for all,
                  even if it had its dark and authoritarian, patriarchal and chauvinist dimensions,
                  and the fear of all that was promised, which manifested itself only in its
                  constant control over history and sexuality. The archive of the underground or
                  subcultural or alternative scene in Ljubljana is a real indicator of its strength.
                  This scene was not a bourgeois oppositional force, but a dissident post-Marxist
                  theoretical and practical basis for the creation of a new culture for the future
                  that powerfully incorporated class struggle, anti-discrimination in socialism, and
                  the option for the future.</p>
               <ul style="text-align:justify;">The archive consists of four clusters that can be
                  read independently, in parallel, diagonally, or in an interweaving of artistic,
                  technological, and social events.<br/><br/>
                  <li style="text-align:justify;"><b>The first cluster refers to the ??KUC
                        gallery.</b> I have archived this event in a single large chronology, which
                     summarizes the events in the gallery of the Student Cultural and Art Center
                     (??KUC) in Ljubljana in the period from 1978 to 1987. The ??KUC association
                     acquired an exhibition space at Stari trg 21 in the center of Ljubljana in
                     1978. In 1987 Sinteza: Magazine for Fine Arts invited me to edit, trace, write
                     and document the work of this gallery, which was at the center of subcultural
                     activity in Ljubljana. This is what I did. Sinteza: Magazine for Fine Arts,
                     which had been published by the Federation of Slovenian Architects'
                     Associations in Ljubljana since 1964, was discontinued in 1994. Because of the
                     great interest, we have now decided to digitize everything. This block of
                     history in Sinteza: Magazine for Fine Arts, which was also published as a
                     separate catalog, is now equipped with much better reproductions and numerous,
                     fully digitized publications, fanzines and printed publications.</li><br/>
                  <li style="text-align:justify;"><b>The second cluster consists of selected
                        newspaper texts, critical reflections, presentations, interviews ??? published
                        between 1981 and 2005 in newspapers in Slovenia, the former Yugoslavia and
                        its neighbouring countries.</b> These are extensively documented materials
                     that I have archived as an author since 1980, i.e. publications that show the
                     range of significance of the subcultural or alternative scene, both in terms of
                     political reading and the new aesthetics of subculture, the attacks and debates
                     it has generated, as well as continuous publications about events and changes
                     in the field of culture and art on a global scale, in the field of photography,
                     video art and the digital world.<br/><br/> This cluster begins in December
                     1981, when Aina ??mid and I respond to an attack on the punk scene that appears
                     in a daily newspaper, and to the persecution of punks that the media tried to
                     associate with fabricated stories, claiming to be fascist groups. The situation
                     becomes even more violent when I react to the appearance of the Laibach group
                     and later to attacks on the gay community. I try to document all this with
                     carefully selected texts that I have systematically archived for decades. At
                     the same time, this set contains many publications about art, politics, and
                     video and media technology. It also includes an interview with F??lix Guattari
                     from 1987, and this collection covers the period up to the year 2000. In the
                     last decade, it shows the development of new media technology and the impact of
                     digitization on the dream of an open source society.</li><br/>
                  <li style="text-align:justify;"><b>The third cluster contains all issues of
                        Reartikulacija, an artistic-political-theoretical-discursive platform, in
                        their entirety. Thirteen printed issues of the newspaper Reartikulacija were
                        published as part of this platform. The first appeared in October/November
                        2007, the last in 2010, and all issues are now archived. Reartikulacija was
                        an art project of the group Reartikulacija. Its members were theoreticians,
                        artists, translators, interpreters and producers: Marina Gr??ini??, Sta??
                        Kleindienst, Sebastjan Leban and Tanja Passoni.</b> It was based on a
                     precise intervention logic; through contemporary political theory, criticism,
                     art projects, activism and self-organization, it aimed to intervene in the
                     Slovenian, Balkan and international space. The platform enabled networking with
                     other political subjects, activists and artists interested in the possibility
                     of creating and maintaining a dialog with concrete social and political spaces
                     in Slovenia, Europe and worldwide. The platform was organized on several
                     levels: a journal, creation, production and organization of exhibitions,
                     lectures, presentations and organization of self-education processes/schools of
                     radical theory. We structured the project in such a way that each
                     issue/exhibition/lecture can constantly change and improve, depending on the
                     specific context and thanks to the collaborators from Slovenia and abroad, who
                     enjoyed full autonomy due to their historical, political and artistic
                     background.</li><br/>
                  <li style="text-align:justify;"><b>The fourth cluster consists of selected videos
                        by Marina Gr??ini?? and Aine ??mid, a tandem that has been active since
                        1982.</b> In the forty years of our activity we have captured the artistic,
                     cultural, technological, political and social reality of Slovenia. This
                     selection is sparse and brings only selected productions that define the
                     current artistic and documentary cuts of the entire space for all these four
                     decades.</li>
               </ul>
            </div>
         </li>
         <li class="accordion-item is-active" data-accordion-item="">
            <!-- Accordion tab title -->
            <a href="#" class="accordion-title">Paralelne zgodovine opolnomo??enja in urbanosti
               Slovenije 1980???1990???2000<br/></a>
            <!-- Accordion tab content: it would start in the open state due to using the `is-active` state class. -->
            <div class="accordion-content" data-tab-content="">
               <h3 style="text-align:center;">Od ljubljanske subkulturne scene do novomedijske scene
                  v Sloveniji</h3>
               <docAuthor>
                  <h3 style="text-align:center;">Marina Gr??ini??</h3>
               </docAuthor>
               <p style="text-align:justify;">Ta celoten pregled sem pripravila na na??in
                  genealogije, torej na na??in zavzete, situirane in vizijsko zastavljene zgodovine,
                  ki se razvija v ??asu. ??as, ki ga zajema, je obdobje prej??njega stoletja, ki se
                  za??ne leta 1978, pa vse do novega tiso??letja. V tem ??asu zaznavamo produkcijo v polju
                  umetnosti, kulture, tehnologije in dru??benega, ki je nenadoma in za vselej celoten
                  prostor in ??e posebej Ljubljano spremenila iz nepomembne vasi v zavzeto mesto z
                  odprtim pogledom v prihodnost. Vse, kar se je vzpostavilo v teh dekadah, je
                  pustilo pe??at: urbanost, za????ita ??lovekovih pravic, coming out LGBTQI+ skupnosti,
                  antimilitaristi??ni pogled na svet ter pogled na tehnologijo kot odprto kodo in
                  nenazadnje vizija pomena antikolonialnih in antikapitalisti??nih bojev. Vse to
                  omogo??a Sloveniji, da v novem tiso??letju ??e enkrat izbere prihodnost.</p>
               <p style="text-align:justify;">Naslov pove??e alternativno ali subkulturno sceno v
                  Ljubljani v osemdesetih, ??as, ko Ljubljana ni glavno mesto Slovenije temve?? glavno
                  mesto Socialisti??ne republike Slovenije v sestavi nekdanje Jugoslavije in
                  medijskega sveta, ki je danes pre??et z dru??benimi platformami, intermedijskimi
                  povezavami, mobilno telefonijo in digitalno virtualno realnostjo sveta, torej tudi
                  prostor, ki je ve?? kot le Slovenija. Subkulturna oziroma alternativna scena
                  Ljubljane v tistem ??asu, njena progresivna politi??na, kulturna in dru??bena dr??a v
                  javnem socialisti??nem ??ivljenju, je v osemdesetih letih postavila Ljubljano na
                  zemljevid urbanih naprednih sredi????. Po punkovski revoluciji (od leta 1977 do
                  tranzicije v postpunkovski svet v osemdesetih) je leta 1984 sledil coming out, ta
                  veliki preboj LGBT skupnosti na plano, z organizacijo prvega javnega Magnus
                  festivala z naslovom ??Homoseksualnost in kultura?? v Galeriji ??KUC.</p>
               <p style="text-align:justify;">Paralelno so ti veliki dogodki, punk ter
                  ??Homoseksualnost in kultura??, video subkultura, vizualna kultura, punk in
                  post-punk podobe, pomenili dru??beni in politi??ni prevrat pojmovanja mladine in
                  spolnosti. A pri tem ni ??lo za prevrat ali ??eljo po uni??enju socializma, pa?? pa
                  odlo??enost, da se ga progresivno zapopade prav v tisti utopi??ni dimenziji, ki se
                  je kazala v retori??nem polju. Kajti samoupravni socializem, na katerega je
                  pritiskal realni socializem (ki je bil stalinisti??no obarvan), je, ??e ni?? drugega,
                  obljubljal enakost in mo??nosti za vse, mo??nost gradnje prihodnosti za vse, ??etudi
                  je imel svoje mra??ne in avtoritarne, patriarhalne in ??ovinisti??ne dimenzije ter
                  strah pred vsem, kar se je obljubljalo, kar je bilo razvidno ??e samo v njegovi
                  neomajni kontroli zgodovine in spolnosti. Arhiv undergrounda ali subkulturne
                  oziroma alternativne scene v Ljubljani je resni??ni pokazatelj njene mo??i. Ta scena
                  ni bila nikakr??na me????anska opozicijska sila pa?? pa disidentska post-marksisti??na
                  teoreti??na in prakti??na osnova produkcije nove kulture za prihodnost, ki je v
                  svojo politiko povzela razredni boj, boj proti diskriminacijam v socializmu in z
                  vsemi mo??nimi silami uveljavila opcijo prihodnosti.</p>
               <ul style="text-align:justify;">
                  <b>Arhiv sestavljajo ??tirje sklopi, ki jih lahko beremo samostojno, vzporedno,
                     diagonalno ali pa v prepletu umetni??kih, tehnolo??kih in dru??benih dogajanj.</b>
                  <br/>
                  <br/>
                  <li style="text-align:justify;"><b>Prvi sklop se nana??a na Galerijo ??KUC</b>. To
                     dogajanje sem arhivirala v enem samem velikem delu kronologije, ki je dogajanje
                     v Galeriji ??tudentskega kulturnega in umetni??kega centra v Ljubljani rezimirala
                     v obdobju od leta 1978 do leta 1987. Dru??tvo ??KUC je leta 1978 pridobilo
                     razstavne prostore na Starem trgu 21 v centru Ljubljane. Leta 1987 me je
                     Sinteza: Revija za likovno kulturo povabila, da uredim, trasiram, zapi??em in
                     dokumentiram delo te galerije, ki je bila v centru subkulturnega dogajanja v
                     Ljubljani. To sem tudi naredila. Sinteza, ki jo je v Ljubljani izdajala Zveza
                     dru??tev arhitektov Slovenije vse od leta 1964 je prenehala izhajati leta 1994.
                     Zaradi velikega interesa smo se sedaj odlo??ili vse to digitalizirati. Ta blok
                     zgodovine v Sintezi, ki so ga izdali tudi kot separat katalog, smo sedaj
                     opremili z mnogo bolj??imi reprodukcijami ter ??tevilnimi, v celoti
                     digitaliziranimi publikacijami, fanzini in tiskanimi publikacijami.</li>
                  <br/>
                  <li style="text-align:justify;"><b>Drugi sklop predstavljajo izbrani ??asopisni
                        teksti, kriti??ne refleksije, prezentacije, intervjuji, ki smo jih od leta
                        1981 do leta 2005 objavljali v ??asopisju v Sloveniji, v nekdanji Jugoslaviji
                        in njenih sosedah.</b> Gre za obse??no dokumentiran material, ki sem ga kot
                     avtorica arhivirala od leta 1980 naprej, torej za objave, ki poka??ejo razpon
                     pomena subkulturne ali alternativne scene, tako v smislu politi??nega branja in
                     nove estetike subkulture, napadov in razprav, ki jih je ta proizvedla, kot tudi
                     kontinuiranega objavljanja o dogajanjih in spremembah na podro??ju kulture in
                     umetnosti v svetovnem merilu, na podro??ju fotografije, video umetnosti in
                     digitalnega sveta. <br/><br/>Ta sklop se za??ne z decembrom leta 1981, ko z Aino
                     ??mid odgovoriva na napad na punkovsko sceno, ki se pojavi v dnevnem ??asopisu,
                     in gonjo proti punkerjem, ki jo mediji sku??ajo povezati s skonstruiranimi
                     zgodbami, ??e?? da gre za fa??isti??ne zdru??be. Situacija zadobi ??e nasilnej??i
                     obraz z odzivom na pojav skupine Laibach ter kasneje z napadi na gejevsko
                     skupnost. Vse to sku??am dokumentirati s skrbno izbranimi teksti, ki sem jih
                     na??rtno arhivirala ve?? desetletjih. Hkrati ta sklop prina??a mnogo objav o
                     umetnosti, politiki in video in medijski tehnologiji. Vsebuje tudi intervju s
                     F??lixom Guattarijem iz leta 1987. Ta sklop pokrije ??as vse do leta 2000. V
                     zadnji dekadi poka??e razvoj novomedijske tehnologije ter vpliv digitalizacije
                     na sanje o odprtokodni dru??bi.</li>
                  <br/>
                  <li style="text-align:justify;"><b>Tretji sklop prina??a v celoti vse ??tevilke
                        Reartikulacije, umetni??ko-politi??ne-teoreti??ne-diskurzivne platforme. V
                        okviru te platforme je iz??lo trinajst tiskanih ??tevilk ??asopisa
                        Reartikulacija. Prva je iz??la oktobra/novembra 2007, zadnja leta 2010. Vse
                        ??tevilke so zdaj arhivirane. Reartikulacija je bila umetni??ki projekt
                        skupine Reartikulacija, ki so jo sestavljali teoretiki, umetniki, prevajalci
                        in producenti: Marina Gr??ini??, Sta?? Kleindienst, Sebastjan Leban in Tanja
                        Passoni.</b> Temeljila je na natan??ni intervencijski logiki: s sodobno
                     politi??no teorijo, kritiko, umetni??kimi projekti, aktivizmom in
                     samoorganizacijo pose??i v slovenski, balkanski in mednarodni prostor. Platforma
                     je omogo??ala povezovanje z drugimi politi??nimi subjekti, aktivisti in umetniki,
                     ki jih je zanimala mo??nost ustvarjanja in vzdr??evanja dialoga s konkretnimi
                     dru??benimi in politi??nimi prostori v Sloveniji, Evropi in po svetu. Platforma
                     je bila organizirana na ve??ih ravneh: kot revija, ustvarjanje, produkcija in
                     organizacija razstav, predavanj in predstavitev ter organizacija
                     samoizobra??evalnih procesov / ??ola za radikalno teorijo. Projekt smo
                     strukturirali na na??in, da je omogo??al nenehno spreminjanje in nadgrajevanje
                     vsake naslednje ??tevilke, razstave ali predavanja glede na specifi??en kontekst
                     in zaradi sodelavcev iz Slovenije in tujine, ki jim je bila dana popolna
                     avtonomija glede na zgodovinsko, politi??no in umetni??ko delo. Reartikulacija je
                     torej vzpostavljala razli??ne politi??ne in teoretske prakse za sodobno umetnost
                     in kulturo ter civilno dru??bo. Bila je umetni??ki projekt, ki je z natan??no
                     interventno logiko temeljil na prepri??anju, da je s kriti??nim, politi??nim in
                     umetni??kim diskurzom mogo??e proizvesti pomembne spremembe v ??ir??em
                     dru??benopoliti??nem prostoru.</li>
                  <br/>
                  <li style="text-align:justify;"><b>??etrti sklop sestavljajo izbrani videi avtoric
                        Marine Gr??ini?? in Aine ??mid, tandema, ki deluje vse od leta 1982.</b> V
                     obdobju najinega ??tiridesetletnega delovanja (1982-2022) sva detektirali
                     umetni??ko, kulturno, tehnolo??ko politi??no in dru??beno realnost prostora
                     Slovenije. Ta izbor je skop in prina??a le izbrano produkcijo, ki za vsa ta
                     ??tiri desetletja vzpostavlja aktualne umetni??ko-dokumentarne reze celotnega
                     prostora.</li>
               </ul>
            </div>
         </li>
      </ul>


   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
      <param name="tei-id"/>
      <param name="sistoryAbsolutePath"/>
   </doc>
   <xsl:template name="tipuesearch_content">
      <xsl:param name="tei-id"/>
      <xsl:param name="sistoryAbsolutePath"/>
      <xsl:variable name="datoteka-js" select="concat($outputDir, 'tipuesearch_content.js')"/>
      <xsl:result-document href="{$datoteka-js}" method="text" encoding="UTF-8">
         <!-- ZA??ETEK JavaScript dokumenta -->
         <xsl:text>var tipuesearch = {"pages": [
                                    </xsl:text>
         <!-- Shrani celotno besedilo v indeks za:
                     - vse child elemente od div, ki imajo @xml:id;
                     - vse child elemente od izbranih list elementov:
                         - list element ne sme imeti @xml:id,
                         - child element mora imeti @xml:id
                -->
         <xsl:for-each select="
               //node()[ancestor::tei:TEI/@xml:id = $tei-id][@xml:id][ancestor::tei:text][parent::tei:div][not(self::tei:div)] |
               //tei:listPerson[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listPlace[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listOrg[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listEvent[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:listBibl[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
               //tei:list[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id]">
            <!--<xsl:variable name="ancestorChapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>-->
            <xsl:variable name="generatedLink">
               <!--<xsl:apply-templates mode="generateLink" select="."/>-->
               <!-- Druga??e procesiram: upo??tevam div[@rend='nosplit'] -->
               <xsl:value-of
                  select="concat(ancestor::tei:div[@xml:id][not(@rend = 'nosplit')][1]/@xml:id, '.html#', @xml:id)"
               />
            </xsl:variable>
            <xsl:variable name="besedilo">
               <xsl:apply-templates mode="besedilo"/>
            </xsl:variable>
            <xsl:variable name="title-first">
               <xsl:apply-templates select="parent::tei:div/tei:head[1]" mode="chapters-head"/>
            </xsl:variable>

            <xsl:text>{ "title": "</xsl:text>
            <xsl:value-of
               select="normalize-space(translate(translate($title-first, '&#xA;', ' '), '&quot;', ''))"/>
            <!--<xsl:value-of select="normalize-space(translate(translate(ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/tei:head[1],'&#xA;',' '),'&quot;',''))"/>-->
            <xsl:text>", "text": "</xsl:text>
            <xsl:value-of
               select="normalize-space(translate($besedilo, '&#xA;&quot;&#92;', '&#x20;'))"/>
            <xsl:text>", "tags": "</xsl:text>
            <xsl:text>", "url": "</xsl:text>
            <xsl:value-of select="concat($sistoryAbsolutePath, $generatedLink)"/>
            <!--<xsl:value-of select="concat($ancestorChapter-id,'.html#',@xml:id)"/>-->
            <xsl:text>" }</xsl:text>
            <xsl:if test="position() != last()">
               <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#xA;</xsl:text>
         </xsl:for-each>

         <!-- KONEC JavaScript dokumenta -->
         <xsl:text>
                     ]};
                </xsl:text>
      </xsl:result-document>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Vklju??i youtube kodo</desc>
   </doc>
   <xsl:template match="tei:media[@mimeType = 'video/youtube' or @mimeType = 'video/x-youtube']">
      <div class="responsive-embed">
         <iframe width="560" height="315"
            src="https://www.youtube.com/embed/{tokenize(@url,'/')[last()]}" frameborder="0"
            allowfullscreen=""/>
      </div>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>video prikaz</desc>
   </doc>
   <xsl:template match="tei:media[@mimeType = 'video/mp4']">
      <video width="650" height="420" controls="">
         <source src="{@url}" type="video/mp4"/> Your browser does not support the video tag.
      </video>
   </xsl:template>



</xsl:stylesheet>
