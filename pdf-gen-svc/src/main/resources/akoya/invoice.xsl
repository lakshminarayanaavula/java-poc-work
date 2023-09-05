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
    <!-- Template to format amount fields -->
    <xsl:template name="specialFormatAmountField">
        <xsl:param name="amount" />
        <xsl:choose>
            <xsl:when test="$amount &lt; 0">
                <fo:inline>
                    (<xsl:value-of select="format-number((-$amount),'###,###,##0.0000')"/>)
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:value-of
                            select="format-number($amount,'###,###,##0.0000')" />
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
                        <fo:table-column column-width="100%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell text-align="right">
                                    <fo:block margin-top="3pt">
                                        <fo:external-graphic
                                                width="0.5in"
                                                height="0.4in" content-height="0.4in"
                                                src="main-logo.png"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                    <fo:block margin-top="15px" xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statement-data"/>
                    </fo:block>
                    <fo:block margin-top="45px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="products"/>
                    </fo:block>
                    <fo:block margin-top="3px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="subtotal"/>
                    </fo:block>
                    <xsl:if test="adjustmentList">
                        <fo:block margin-top="3px"
                                  xsl:use-attribute-sets="myfont">
                            <xsl:call-template name="adjustment"/>
                        </fo:block>

                        <fo:block margin-top="3px"
                                  xsl:use-attribute-sets="myfont">
                            <xsl:call-template name="subtotal-adjustment"/>
                        </fo:block>
                    </xsl:if>
                    <fo:block padding-top="15mm"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statement-address"/>
                    </fo:block>

                </fo:flow>

            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="statement-address">
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="60%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-size="12pt" font-weight="bold">
                            Due Date:
                            <xsl:if test="dueDate!='null'">
                                <xsl:call-template name="convertToDate">
                                    <xsl:with-param name="timestamp" select="dueDate" />
                                </xsl:call-template>
                            </xsl:if>
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Electronic funds transfer details:
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Bank Name:&#160; Bank Of America
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Account Name:&#160; Akoya LLC
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Checking Account Number:&#160; 466001414297
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            ABA Routing Number:&#160; 011000138
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Wire Routing Number:&#160; 026009593
                        </fo:block>
                        <fo:block margin-bottom="0.3mm">
                            Swift Code:&#160; BOFAUS3N
                        </fo:block>
                        <xsl:if test="paymentLink!='null'">
                            <fo:block margin-top="6pt">
                                <fo:external-graphic
                                        width="0.5in"
                                        height="0.4in" content-height="0.4in"
                                        src="payment_type.png"/>
                            </fo:block>
                            <fo:block margin-top="1mm" font-size="14pt">
                                <fo:basic-link>
                                    <xsl:attribute name="external-destination">
                                        <xsl:value-of select="paymentLink"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="color">
                                        <xsl:text>blue</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="text-decoration">
                                        <xsl:text>underline</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>View and pay online now</xsl:text>
                                </fo:basic-link>
                            </fo:block>
                        </xsl:if>

                    </fo:table-cell>
                    <fo:table-cell margin-bottom="0.3mm">
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="statement-data">
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block font-size="15pt">
                                            INVOICE
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="0.3mm">
                                        <fo:block>&#160;&#160;&#160;<xsl:value-of select="account/name"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <xsl:for-each select="account/addresses">
                                    <xsl:if test="type='BILLING'">
                                        <fo:table-row>
                                            <fo:table-cell padding="0.3mm">
                                                <fo:block>&#160;&#160;&#160;<xsl:value-of select="address1"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell padding="0.3mm">
                                                <fo:block>&#160;&#160;&#160;<xsl:value-of select="city"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                        <fo:table-row>
                                            <fo:table-cell padding="0.3mm">
                                                <fo:block>&#160;&#160;&#160;<xsl:value-of select="state"/>&#160;<xsl:value-of
                                                        select="zip"/>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:if>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block font-weight="bold">
                                            Invoice Date
                                        </fo:block>
                                        <fo:block>
                                            <xsl:call-template name="convertToDate">
                                                <xsl:with-param name="timestamp" select="toDate" />
                                            </xsl:call-template>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block font-weight="bold">
                                            Invoice Number
                                        </fo:block>
                                        <fo:block>
                                            <xsl:value-of select="invoiceNo"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding="1mm">
                                        <fo:block font-weight="bold">
                                            Reference
                                        </fo:block>
                                        <fo:block>
                                            Akoya DAN Subscription
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block padding="1mm">
                            Akoya LLC
                        </fo:block>
                        <fo:block padding="0.3mm">
                            6 Liberty Square, #2381
                        </fo:block>
                        <fo:block padding="0.3mm">
                            Boston, MA 02109
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="subtotal">
        <fo:table width="100%" table-layout="fixed" font-size="8pt" text-align="right">
            <fo:table-column column-width="80%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block>
                            Subtotal
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="right" padding-left="5mm">
                        <fo:block>
                            $
                            <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount" select="subTotalAmount"/>
                            </xsl:call-template>

                        </fo:block>
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
                            $
                            <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount" select="tax"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:if test="not(adjustmentList)">
                    <fo:table-row text-align="center">
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                Total Due
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                $
                                <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount" select="totalDueAmount"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="subtotal-adjustment">
        <fo:table width="100%" table-layout="fixed" font-size="8pt" text-align="right">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="13%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-body>
                <xsl:if test="adjustmentList">
                    <fo:table-row>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                Subtotal
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right" padding-left="5mm">
                            <fo:block>
                                $<xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount" select="adjustmentAmount"/>
                            </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                    <fo:table-row>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right" padding-left="5mm">
                            <fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                    <fo:table-row text-align="center">
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                Total Due
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       display-align="center">
                            <fo:block>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                $
                                <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount" select="totalDueAmount"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>

                </xsl:if>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="adjustment">
        <fo:block font-weight="bold" font-size="8pt" padding-bottom="2mm" padding-top="5mm">
            Adjustments
        </fo:block>

        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>

            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Statement#</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Reason</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block></fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>Amount</fo:block>
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
                <xsl:for-each select="adjustmentList">
                    <fo:table-row text-align="center">
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                <xsl:value-of select="adjustedInvoiceNumber"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="left">
                            <fo:block>
                                <xsl:value-of select="description"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                            <fo:block>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                $
                                <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount" select="amount"/>
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
                </fo:table-row>
            </fo:table-body>

        </fo:table>

    </xsl:template>
    <xsl:template name="products">
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="14%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Product</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Service Description</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>Count</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>Fee Rate</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="right">
                        <fo:block>Total</fo:block>
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
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="billItems">
                    <xsl:if test="not(quantity=0 and amount=0)">
                        <fo:table-row text-align="center">
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <fo:block>
                                    <xsl:value-of select="appCode"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <xsl:choose>
                                    <xsl:when test="billEndDate!='null' and billStartDate!='null'">
                                        <fo:block>
                                            <xsl:value-of select="description"/>
                                            (<xsl:call-template name="convertToDate">
                                            <xsl:with-param name="timestamp" select="billStartDate" />
                                        </xsl:call-template> to
                                            <xsl:call-template name="convertToDate">
                                                <xsl:with-param name="timestamp" select="billEndDate" />
                                            </xsl:call-template>)
                                        </fo:block>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <fo:block>
                                            <xsl:value-of select="description"/>
                                        </fo:block>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    <xsl:value-of select="format-number(quantity, '###,##0')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">

                                <xsl:if test="priceMethodType='AMOUNT'">
                                    <fo:block>
                                        <xsl:call-template name="specialFormatAmountField">
                                            <xsl:with-param name="amount" select="unitPrice"/>
                                        </xsl:call-template>

                                    </fo:block>
                                </xsl:if>
                                <xsl:if test="not(priceMethodType='AMOUNT')">
                                    <fo:block>
                                        $
                                        <xsl:call-template name="specialFormatAmountField">
                                            <xsl:with-param name="amount" select="unitPrice"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </xsl:if>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    $
                                    <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount" select="amount"/>
                                    </xsl:call-template>

                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>

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
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <!-- Date format -->
    <xsl:template name="convertToDate">
        <xsl:param name="timestamp" />
        <xsl:variable name='parser'
                      select='java:java.text.SimpleDateFormat.new("yyyy-MM-dd")' />
        <xsl:variable name='date'
                      select='fn:parse($parser,$timestamp)' />
        <xsl:variable name='formatter'
                      select='java:java.text.SimpleDateFormat.new("MMM dd, yyyy")' />
        <xsl:variable name='readable-date'
                      select='fn:format($formatter,$date)' />
        <xsl:value-of select="$readable-date" />
    </xsl:template>
</xsl:stylesheet>
