<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:fn="fn"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:java="http://xml.apache.org/xslt/java"
                exclude-result-prefixes="fo java">
    <!-- Declaring global variables -->
    <xsl:variable name="varNormalBGColor">
        #ffffff
    </xsl:variable>
    <xsl:variable name="varAccentBGColor">
        #b5b2b2
    </xsl:variable>
    <!-- Declaring attributes for margin -->
    <xsl:attribute-set name="margin_left">
        <xsl:attribute name="margin-left">0.0in</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template match="invoice">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="firstPage"
                                       page-height="11in" page-width="8.5in" margin="0.01in">
                    <fo:region-body region-name="region-body"
                                    margin-bottom="0.7in" margin-top="0in"/>
                    <fo:region-after region-name="footer" extent=".5in"/>
                </fo:simple-page-master>
                <fo:simple-page-master master-name="nextPage"
                                       page-height="11in" page-width="8.5in" margin="0.01in">
                    <fo:region-body region-name="region-body"
                                    margin-bottom="0.5in"/>
                    <fo:region-after region-name="footer"
                                     extent="0.5in"/>
                </fo:simple-page-master>
                <fo:page-sequence-master
                        master-name="InvoiceDetails">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference
                                master-reference="firstPage" page-position="first"/>
                        <fo:conditional-page-master-reference
                                master-reference="nextPage" page-position="rest"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="InvoiceDetails">
                <fo:static-content flow-name="footer">

                    <fo:block text-align="right" margin-top="-5mm" margin-right="1mm"
                              font-size="10pt">
                        <fo:inline font-size="10pt">Page</fo:inline>
                        <xsl:text>  </xsl:text>
                        <fo:inline>
                            <fo:page-number>1</fo:page-number>
                            <!--							<fo:page-number/>-->
                        </fo:inline>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="region-body" background-color="#FFFFFF">
                    <fo:block-container>
                        <fo:block margin-left="0.1in" margin-right="0.2in"
                                  margin-top="0.3in">
                            <xsl:call-template name="header_with_logo"/>
                        </fo:block>
                    </fo:block-container>
                    <fo:block-container>
                        <fo:block margin-left="0.1in" margin-right="0.2in"
                                  margin-top="0.1in">
                            <xsl:call-template
                                    name="header_with_address_invoice_details"/>
                        </fo:block>
                    </fo:block-container>
                    <fo:block-container>
                        <fo:block margin-left="0.1in" margin-right="0.2in"
                                  margin-top="0.1in">
                            <xsl:call-template name="bill_to_address"/>
                        </fo:block>
                    </fo:block-container>
                    <fo:block-container>
                        <fo:block margin-left="0.1in" margin-right="0.2in"
                                  margin-top="0.1in">
                            <xsl:call-template name="invoice_details"/>
                        </fo:block>
                    </fo:block-container>
                    <fo:block-container>
                        <fo:block margin-left="0.1in" margin-right="0.2in"
                                  margin-top="1in">
                            <xsl:call-template name="customer_address"/>
                        </fo:block>
                    </fo:block-container>
                    <!--                    <fo:block-container>-->
                    <!--                        <fo:block margin-left="0.1in" margin-right="0.2in"-->
                    <!--                                  margin-top="1in">-->
                    <!--                            <xsl:call-template name="office_address"/>-->
                    <!--                        </fo:block>-->
                    <!--                    </fo:block-container>-->

                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="bill_to_address">
        <fo:table width="100%" table-layout="fixed" font-size="7pt"
                  margin-left="-1mm">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-left="2mm" margin-top="50mm" font-size="9pt">
                        <fo:block>
                            <fo:inline font-weight="bold">Bill To :
                            </fo:inline>
                        </fo:block>
                        <xsl:call-template name="billing_to_address_template"/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="billing_to_address_template">

        <xsl:for-each select="account/addresses[type='BILLING']">
            <!--<fo:block>
                <xsl:value-of select="account/name"/>
            </fo:block>
            <fo:block>
                <xsl:value-of select="account/address"/>
            </fo:block>-->
            <fo:block>
                <xsl:value-of select="concat(address1,',')"/>
            </fo:block>
            <fo:block>
                <xsl:value-of select="concat(address2,',')"/>
            </fo:block>
            <fo:block>
                <xsl:value-of select="concat(city,', ',state,' ',zip)"/>
            </fo:block>
            <fo:block>
                US
            </fo:block>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="invoice_details">
        <fo:table width="100%" table-layout="fixed" font-size="7pt"
                  margin-left="3mm" margin-top="5mm">
            <fo:table-column column-width="80%"/>
            <fo:table-column column-width="18%"/>

            <fo:table-header>
                <fo:table-row height="20pt">
                    <fo:table-cell background-color="#ddeaf5" border-top="1px solid black" border-left="1px solid black"
                                   border-bottom="1px solid black">
                        <fo:block xsl:use-attribute-sets="margin_left"
                                  margin-top="2pt" font-size="10pt" text-align="left" padding-left="1in">
                            <fo:inline>DESCRIPTION</fo:inline>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell background-color="#ddeaf5" border-top="1px solid black" border-right="1px solid black"
                                   border-bottom="1px solid black">
                        <fo:block xsl:use-attribute-sets="margin_left"
                                  margin-top="2pt" font-size="10pt" margin-right="10pt" text-align="right">
                            <fo:inline>AMOUNT</fo:inline>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell border-left="1px solid black">
                        <fo:block xsl:use-attribute-sets="margin_left"
                                  margin-top="2pt" font-size="7pt" text-align="left">
                            <xsl:text>&#160;</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border-right="1px solid black" text-align="right">
                        <fo:block margin-top="2pt" font-size="7pt" padding-right="0pt">
                            <xsl:text>&#160;</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <!--<fo:block>
                    <xsl:call-template name="convertToDate">
                        <xsl:with-param name="timestamp" select="billItems/description" />
                    </xsl:call-template>
                </fo:block>-->

                <xsl:for-each select="billItems">
                    <fo:table-row>
                        <fo:table-cell border-left="1px solid black">
                            <fo:block xsl:use-attribute-sets="margin_left" padding-bottom="2mm" margin-left="-5pt" margin-top="-7pt" font-size="9pt" text-align="left">
                                <fo:inline>
                                    <xsl:choose>
                                        <xsl:when test="contains(date, '/')">
                                            <xsl:call-template name="convertToDate">
                                                <xsl:with-param name="timestamp" select="date"/>
                                            </xsl:call-template>
                                            <xsl:value-of select="description"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="date"/>
                                        </xsl:otherwise>

                                    </xsl:choose>

                                </fo:inline>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-right="1px solid black">
                            <fo:block margin-right="-12pt" margin-top="-7pt" font-size="9pt" text-align="right" padding-bottom="2mm">
                                <xsl:choose>
                                    <xsl:when test="amount &lt; 0">
                                        <xsl:text>($</xsl:text>
                                        <xsl:value-of select="format-number(-amount, '###,##0.00')"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>$</xsl:text>
                                        <xsl:value-of select="format-number(amount, '###,##0.00')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

                <!--<xsl:if test="adjustmentList">
                    <fo:table-row>
                        <fo:table-cell border-left="1px solid gray">
                            <fo:block xsl:use-attribute-sets="margin_left"
                                      margin-top="2pt" font-size="7pt" text-align="left">
                                <xsl:text>&#160;</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-right="1px solid gray" text-align="right">
                            <fo:block margin-top="2pt" font-size="7pt" padding-right="0pt">
                                <xsl:text>&#160;</xsl:text>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell border-left="1px solid gray">
                            <fo:block xsl:use-attribute-sets="margin_left"
                                      margin-top="2pt" font-size="7pt" text-align="left">

                                <fo:inline font-weight="bold">Adjustments</fo:inline>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-right="1px solid gray" text-align="right">
                            <fo:block margin-top="2pt" font-size="7pt" padding-right="0pt">
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </xsl:if>
                <xsl:for-each select="adjustmentList">
                    <fo:table-row>
                        <fo:table-cell border-left="1px solid gray">
                            <fo:block xsl:use-attribute-sets="margin_left"
                                      margin-top="2pt" font-size="7pt" text-align="left">
                                <fo:inline>
                                    <xsl:value-of select="description"/>
                                </fo:inline>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell border-right="1px solid gray" text-align="right">
                            <fo:block margin-top="2pt" font-size="7pt" padding-right="0pt">
                                $<xsl:value-of select="format-number(amount, '###,##0.00')"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>-->
                <fo:table-row>
                    <fo:table-cell border-left="1px solid black">
                        <fo:block xsl:use-attribute-sets="margin_left"
                                  margin-top="2pt" font-size="7pt" text-align="left">
                            <xsl:text>&#160;</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border-right="1px solid black" text-align="right">
                        <fo:block margin-top="2pt" font-size="7pt" padding-right="0pt">
                            <xsl:text>&#160;</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell border-top="1px solid black">
                        <fo:block xsl:use-attribute-sets="margin_left"
                                  margin-right="-8pt" margin-top="2pt" font-size="9pt" text-align="right">
                            <fo:inline>TOTAL (USD)</fo:inline>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="1px solid black">
                        <fo:block margin-top="2pt" font-size="9pt" text-align="right" margin-right="-12pt">
                            $<xsl:value-of select="format-number(balance, '###,##0.00')"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>

        </fo:table>
    </xsl:template>

    <!-- Template to format date -->
    <xsl:template name="convertToDate">
        <xsl:param name="timestamp" />
        <xsl:variable name='parser'
                      select='java:java.text.SimpleDateFormat.new("yyyy/MM/dd")' />
        <xsl:variable name='date' select='fn:parse($parser,$timestamp)'/>
        <xsl:variable name='formatter'
                      select='java:java.text.SimpleDateFormat.new("MMMMMMMMM yyyy")' />
        <xsl:variable name='readable-date'
                      select='fn:format($formatter,$date)' />
        <xsl:value-of select="$readable-date" />
    </xsl:template>


    <xsl:template name="header_with_address_invoice_details">
        <fo:table width="75%" table-layout="fixed" font-size="7pt"
                  margin-left="-2mm">
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-body margin-top="-75mm">
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-left="2mm">
                                        <fo:block>
                                            Upwork Global Inc.
                                        </fo:block>
                                        <fo:block>
                                            475 Brannan Street, Suite 430
                                        </fo:block>
                                        <fo:block>
                                            San Francisco, California 94107
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" font-size="9pt">
                        <fo:table width="250%" table-layout="fixed"
                                  font-size="9pt">
                            <fo:table-column column-width="50%"/>
                            <fo:table-column column-width="100%" padding-right="50mm" />
                            <fo:table-body text-align="right">
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block >INVOICE# :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left">
                                            <xsl:value-of select="invoiceNo"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block text-align="right">DATE :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" >
                                            <xsl:value-of select="dateStr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block text-align="right">AE# :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" >
                                            <xsl:value-of select="account/accountNo"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block text-align="right">PO :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" ></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block >TEAM NAME :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" ></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block text-align="right"></fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" ></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block>&#160;</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block>&#160;</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block text-align="right">TERMS :</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block text-align="left" >NET 30
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>


                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="header_with_logo">
        <fo:inline>
            <fo:external-graphic width="2.5in" height="0.5in"
                                 content-width="2.5in" content-height="0.5in">
                <xsl:attribute name="src">
                    <xsl:value-of select="tenantLogo"/>
                </xsl:attribute>
            </fo:external-graphic>
        </fo:inline>
        <fo:table width="85%" font-size="10pt" table-layout="fixed">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-size="14pt" font-weight="bold"
                                  text-align="right" margin-right="0.2in" padding-right="-5mm" margin-top="12mm">
                            <fo:inline>INVOICE</fo:inline>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <!--<fo:table-row>
                    <fo:table-cell>
                        <fo:block font-size="14pt"
                                  text-align="right" margin-right="0.2in">
                            <fo:inline>Invoice</fo:inline>
                            <xsl:value-of select="invoiceId"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>-->
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="customer_address">
        <!--<fo:table width="100%" table-layout="fixed" font-size="7pt"
                  margin-left="-1mm">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <fo:inline font-weight="bold">Please send payments via wire or ACH to:
                            </fo:inline>
                        </fo:block>

                    </fo:table-cell>
                </fo:table-row>

            </fo:table-body>
        </fo:table>-->
    </xsl:template>
    <xsl:template name="office_address">
        <fo:table width="100%" table-layout="fixed" font-size="7pt"
                  margin-left="-1mm">
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <fo:inline font-weight="bold">Please send payments via check to:
                            </fo:inline>
                        </fo:block>

                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>Upwork Inc.</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>P.O. Box 208676</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>Dallas, TX 75320-8676</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>&#160;</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>Fed Tax ID#: 13-4241242</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>