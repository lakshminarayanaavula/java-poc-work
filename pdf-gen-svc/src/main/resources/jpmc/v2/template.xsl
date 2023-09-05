<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:fn="fn"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:java="http://xml.apache.org/xslt/java"
                exclude-result-prefixes="fo java">
    <xsl:attribute-set name="myborder">
        <xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="box">
        <xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
        <xsl:attribute name="background-color">#9E1606</xsl:attribute>
        <xsl:attribute name="color">white</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="myborderb">
        <xsl:attribute name="border-bottom">solid 0.1mm black</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="mybordert">
        <xsl:attribute name="border">solid 0.2mm black</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="myfont">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="myheadings">
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:template name="formatCurrency">
        <xsl:param name="code" />
        <xsl:choose>
            <xsl:when test="$code = 'EUR'">
                <fo:inline>
                    <xsl:value-of select="'€'"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$code = 'INR'">
                <fo:inline>
                    <xsl:value-of select="'Rs.'"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$code = 'SGD'">
                <fo:inline>
                    <xsl:value-of select="'S$'"/>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:value-of
                            select="'$'" />
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template to format amount fields -->
    <xsl:template name="formatAmountField">
        <xsl:param name="amount" />
        <xsl:choose>
            <xsl:when test="$amount &lt; 0">
                <fo:inline>
                    (<xsl:value-of select="format-number((-$amount),'###,###,##0.00')"/>)
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:value-of
                            select="format-number($amount,'###,###,##0.00')" />
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="formatQuantity">
        <xsl:param name="quantity" />
        <xsl:choose>
            <xsl:when test="$quantity = 'null' or $quantity = '' or string(number($quantity))='NaN'">
                <fo:inline>
                    <xsl:value-of select="''"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="$quantity &lt; 0">
                <fo:inline>
                    (<xsl:value-of select="format-number((-$quantity),'###,###,##0')"/>)
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:value-of
                            select="format-number($quantity,'###,###,##0')" />
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="invoice">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master
                        master-name="A4-portrait" page-height="29.7cm" page-width="21.0cm"
                        margin-top="0.80cm" margin-left="2cm" margin-right="2cm"
                        margin-bottom="1.0cm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4-portrait">
                <fo:flow flow-name="xsl-region-body">
                    <fo:table inline-progression-dimension="auto" table-layout="auto">
                        <fo:table-column column-width="12%"/>
                        <fo:table-column column-width="35%"/>
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="35%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell text-align="left">
                                    <fo:block>
<!--                                        <fo:external-graphic-->
<!--                                                width="0.5in"-->
<!--                                                height="0.4in" content-height="0.4in"-->
<!--                                                src="main-logo.png" />-->
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell text-align="left">
                                    <fo:block font-size="18pt" font-weight="bold" margin-top="7pt">|
                                        Invoice Statement
                                    </fo:block>

                                </fo:table-cell>
                                <fo:table-cell text-align="left">
                                    <xsl:if test="payoutInvoice='true'">
                                        <fo:block font-size="14pt" color="gray" margin-top="10pt">- Fees Earned
                                        </fo:block>
                                    </xsl:if>
                                    <xsl:if test="not(payoutInvoice='true')">
                                        <fo:block font-size="14pt" color="gray" margin-top="10pt">- Fees Charged
                                        </fo:block>
                                    </xsl:if>
                                </fo:table-cell>
                                <fo:table-cell text-align="left">
                                    <fo:block font-size="18pt" font-weight="bold" margin-top="7pt">

                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                    <fo:block margin-bottom="3pt" margin-top="3pt">
                        <xsl:call-template name="heading-separator"></xsl:call-template>
                    </fo:block>
                    <fo:block margin-top="10px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statement-data"/>
                    </fo:block>
                    <fo:block margin-top="10px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="summary"/>
                    </fo:block>
                    <fo:block margin-top="15px"
                              xsl:use-attribute-sets="myfont">
                        <fo:block margin-bottom="1pt" margin-top="1pt">
                            <xsl:call-template name="heading-separator"></xsl:call-template>
                        </fo:block>
                        <xsl:call-template name="currency-count"/>
                    </fo:block>
                    <fo:block margin-top="15px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="products"/>
                    </fo:block>
                    <fo:block margin-top="3px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="subtotal"/>
                    </fo:block>
                    <fo:block margin-top="25px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statementsummary"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="statementsummary">
        <fo:table width="50%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="25%"/>
            <fo:table-column column-width="25%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>Participant ID:</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>
                            <xsl:value-of select="account/accountNo"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>Statement</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>
                            #
                            <xsl:value-of select="invoiceNo"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="statement-data">
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>
                                            <xsl:value-of select="account/name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>
                                            &#160;
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>To:&#160;<xsl:value-of select="fullName"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>Email:&#160;<xsl:value-of select="email"/></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>Statement Period:
                                            <xsl:value-of select="fromDateStr"/>&#160;to&#160;<xsl:value-of select="toDateStr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>Statement Date:
                                            <xsl:value-of select="dateStr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block>Currency:
                                            <xsl:value-of select="account/currency"/>
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
    <xsl:template name="summary">
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block font-weight="bold" text-align="left">
                            For any queries regarding the invoice statement, please contact Support at:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block font-weight="bold" text-align="left">
                            onyx.billing@jpmchase.com
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" text-align="center">
                        <fo:block font-weight="bold">Contact:&#160;&#160;&#160;	Onyx SOLUTION CENTER
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" text-align="right">
                        <fo:block font-weight="bold">551-404-7867</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="subtotal">
        <fo:table width="100%" table-layout="fixed" font-size="8pt" text-align="right">
            <fo:table-column column-width="78%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="10%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block>
                            Total
                        </fo:block>
                    </fo:table-cell>

                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="right" padding-left="5mm">
                        <fo:block>
                            $
                            <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount"
                                                select="subTotalAmount" />
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block>
                            Tax
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="right">
                        <fo:block>
                            <fo:inline>
                                $
                                <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount"
                                                    select="tax" />
                                </xsl:call-template>
                            </fo:inline>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row text-align="center">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block>
                            Total Due After Tax
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="right">
                        <fo:block>
                            $
                            <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount"
                                                select="totalDueAmount" />
                            </xsl:call-template>

                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   display-align="center">
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>



    <xsl:template name="currency-count">

        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="30%"/>

            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Branch Location</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Currency</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="center">
                        <fo:block>Number Of Accounts</fo:block>
                    </fo:table-cell>

                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row width="100%">
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>

                </fo:table-row>
                <xsl:for-each select="currencyCount">
                    <fo:table-row text-align="center">
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                <xsl:value-of select="accountNo"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                <xsl:value-of select="currency"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="center">
                            <fo:block>
                                <xsl:value-of select="count"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    '
                </xsl:for-each>

                <fo:table-row width="100%">
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>

                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="products">
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="23%"/>
            <fo:table-column column-width="5%"/>
            <fo:table-column column-width="13%"/>
            <fo:table-column column-width="10%"/>
            <fo:table-column column-width="10%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="left" >
                        <fo:block>Service Code</fo:block>
                    </fo:table-cell>
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="left">
                        <fo:block>Service Description</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="center">
                        <fo:block>Currency</fo:block>
                    </fo:table-cell>
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="center">
                        <fo:block>Txn. Volume</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="left">
                        <fo:block>Fee Type</fo:block>
                    </fo:table-cell>
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="center">
                        <fo:block>Fee Rate (USD)</fo:block>
                    </fo:table-cell>
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="center">
                        <fo:block>Total Charges (USD)</fo:block>
                    </fo:table-cell>
                    <fo:table-cell  padding-bottom="1mm" padding-top="1mm" display-align="after" text-align="center">
                        <fo:block>Total Charges (Base Ccy)</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row width="100%">
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt"  border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="accountWithInvoiceItems">
                    <fo:table-row width="100%">
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block>
                                <xsl:value-of select="'Account Number :'"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm" font-weight="bold">
                            <fo:block>
                                <xsl:value-of select="accountNumber"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block>
                                <xsl:value-of select="currency"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block> </fo:block>
                        </fo:table-cell>

                    </fo:table-row>
                    <xsl:for-each select="invoiceItems">
                        <fo:table-row width="100%">
                            <fo:table-cell text-align="center" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:value-of select="serviceCode"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:value-of select="serviceDescription"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                <fo:block></fo:block>
                            </fo:table-cell >
                            <fo:table-cell text-align="center" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:call-template name="formatQuantity">
                                        <xsl:with-param name="quantity"
                                                        select="txnVolume" />
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="left" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:value-of select="feeType"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount"
                                                        select="feeRate" />
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    $<xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount"
                                                    select="totalChargeInUSD" />
                                </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="right" padding-bottom="1mm" padding-top="1mm">
                                <fo:block>
                                    <xsl:call-template name="formatCurrency">
                                        <xsl:with-param name="code"
                                                        select="currency" />
                                    </xsl:call-template>
                                    <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount"
                                                        select="totalChargeInBaseCurrency" />
                                    </xsl:call-template>

                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row width="100%">
                        <fo:table-cell>
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                            <fo:block>
                                <xsl:value-of select="'Subtotal'"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right" padding-bottom="1mm" padding-top="1mm">
                            <fo:block>
                                $<xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount"
                                                select="subTotalOfUsdAmount" />
                            </xsl:call-template>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="right" padding-bottom="1mm" padding-top="1mm">
                            <fo:block>
                                <xsl:call-template name="formatCurrency">
                                    <xsl:with-param name="code"
                                                    select="currency" />
                                </xsl:call-template>
                                <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount"
                                                    select="subTotalOfBaseAmount" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>
                <fo:table-row width="100%">
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="heading-separator">
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
                <fo:table-row width="100%">
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="invoice_summary">
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <xsl:if test="(payoutInvoice='true') and (totalDueAmount != 0)">
                            <fo:block margin-bottom="15px">The Amount of

                                <fo:inline font-weight="bold">
                                    $
                                    <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount"
                                                        select="totalDueAmount" />
                                    </xsl:call-template>
                                </fo:inline>
                                will be credited to the account on file within 15 business days of the statement date.
                            </fo:block>
                        </xsl:if>
                        <xsl:if test="(payoutInvoice='false') and (totalDueAmount != 0)">
                            <fo:block margin-bottom="15px">The Amount of
                                <fo:inline font-weight="bold">
                                    $
                                    <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount"
                                                        select="totalDueAmount" />
                                    </xsl:call-template>
                                </fo:inline>
                                will be debited to the account on file within 15 business days of the statement date.
                            </fo:block>
                        </xsl:if>
                        <xsl:if test="totalDueAmount = 0">
                            <fo:block margin-bottom="15px">&#160;</fo:block>
                        </xsl:if>
                        <fo:block></fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>
