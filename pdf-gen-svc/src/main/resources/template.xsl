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
                                        <fo:external-graphic
                                                width="0.5in"
                                                height="0.4in" content-height="0.4in"
                                                src="main-logo.png" />
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
                    <fo:block margin-bottom="5pt" margin-top="5pt">
                        <xsl:call-template name="heading-separator"></xsl:call-template>
                    </fo:block>
                    <fo:block margin-top="15px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statement-data"/>
                    </fo:block>
                    <fo:block margin-top="15px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="summary"/>
                    </fo:block>
                    <fo:block margin-top="15px"
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
                    <fo:block margin-top="5px"
                              xsl:use-attribute-sets="myfont">
                        <xsl:call-template name="statementsummary"/>
                    </fo:block>

                </fo:flow>

            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="statementsummary">
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
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block font-weight="bold">
                            For any queries regarding the invoice statement, please contact Liink support at:
                        </fo:block>
                        <fo:block>
                            https://iinconnect.com/static/contactus or billing@iinconnect.com.
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="subtotal">
        <fo:table width="100%" table-layout="fixed" font-size="8pt" text-align="right">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="13%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-body>
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
                            $
                            <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount"
                                                select="subTotalAmount" />
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
                                   text-align="left">
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                   text-align="left">
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>

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
                                <xsl:with-param name="amount"
                                                select="totalDueAmount" />
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
                                $
                                <xsl:call-template name="formatAmountField">
                                <xsl:with-param name="amount"
                                                select="adjustmentAmount" />
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
                                <xsl:with-param name="amount"
                                                select="totalDueAmount" />
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
                                <xsl:with-param name="amount"
                                                select="amount" />
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
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Product</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Service Description</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Market Id</fo:block>
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
                    <fo:table-cell>
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="billItems">
                    <xsl:if test="not(priceMethodType!='TIERED' and quantity=0 and amount=0)">
                        <fo:table-row text-align="center">
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <fo:block>
                                    <xsl:value-of select="appCode"/>
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
                                    <xsl:value-of select="priceUnitLabel"/>
                                </fo:block>
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
                                        <xsl:call-template name="formatAmountField">
                                            <xsl:with-param name="amount"
                                                            select="unitPrice" />
                                        </xsl:call-template>%

                                    </fo:block>
                                </xsl:if>
                                <xsl:if test="not(priceMethodType='AMOUNT')">
                                    <fo:block>
                                        $
                                        <xsl:call-template name="formatAmountField">
                                        <xsl:with-param name="amount"
                                                        select="unitPrice" />
                                    </xsl:call-template>
                                    </fo:block>
                                </xsl:if>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    $
                                    <xsl:call-template name="formatAmountField">
                                    <xsl:with-param name="amount"
                                                    select="amount" />
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
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="50%"/>
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
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
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>

