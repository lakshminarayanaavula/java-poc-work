<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
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
        <xsl:param name="amount"/>
        <xsl:choose>
            <xsl:when test="$amount &lt; 0">
                <fo:inline>
                    (<xsl:value-of select="format-number((-$amount),'###,###,##0.00')"/>)
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:value-of
                            select="format-number($amount,'###,###,##0.00')"/>
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

                        <fo:table-column column-width="52%"/>
                        <fo:table-column column-width="25%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-body>
                            <fo:table-row>

                                <fo:table-cell text-align="left">
                                    <fo:block font-size="15pt" font-weight="bold" margin-top="7pt">
                                        MONETIZE360 | Invoice Statement
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell text-align="left">
                                    <xsl:if test="payoutInvoice='true'">
                                        <fo:block font-size="14pt" color="gray" margin-top="8pt">- Fees Earned
                                        </fo:block>
                                    </xsl:if>
                                    <xsl:if test="not(payoutInvoice='true')">
                                        <fo:block font-size="14pt" color="gray" margin-top="8pt">- Fees Charged
                                        </fo:block>
                                    </xsl:if>
                                </fo:table-cell>
                                <fo:table-cell text-align="left">
                                    <fo:block>

                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                    <fo:block margin-bottom="5pt" margin-top="5pt">
                        <xsl:call-template name="heading-separator"/>
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
                </fo:flow>

            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="statement-data">
        <fo:table width="100%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
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
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                        <fo:block>To:&#160;<xsl:value-of select="fullName"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                        <fo:block>Email:&#160;<xsl:value-of select="email"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                        <fo:block>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:table font-size="9pt">
                            <fo:table-column/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                        <fo:block>Statement Period:
                                            <xsl:value-of select="fromDateStr"/>&#160;to&#160;<xsl:value-of
                                                    select="toDateStr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                                        <fo:block>Statement Date:
                                            <xsl:value-of select="dateStr"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row>
                                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
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
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block font-weight="bold">
                            For any queries regarding the invoice statement, please contact MONETIZE360 support at:
                        </fo:block>
                        <fo:block>
                            demo@monetize360.io.
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
                                                    select="tax"/>
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
                                                    select="totalDueAmount"/>
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
                                                    select="adjustmentAmount"/>
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
                                                    select="totalDueAmount"/>
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
                                                    select="amount"/>
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
        <fo:table width="60%" table-layout="fixed" font-size="9pt">
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="30%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>
                            <xsl:value-of select="'Parent'"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>
                            <xsl:value-of select="'Parent Number'"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>
                            <xsl:value-of select="'SEC - Client'"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm">
                        <fo:block>
                            <xsl:value-of select="'SEC-PI-001'"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <fo:block font-weight="bold" font-size="8pt" margin-top="8pt" margin-bottom="5pt">
            Transactions for SEC - Client:
        </fo:block>
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="27%"/>
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Category</fo:block>
                    </fo:table-cell>
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
                    <fo:table-cell number-columns-spanned="7">
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="categoryDetails">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block>
                                <xsl:value-of select="categoryName"/>

                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="items">
                        <fo:table-row text-align="center">
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <fo:block>
                                    <xsl:value-of select="name"/>
                                </fo:block>
                            </fo:table-cell>
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
                                    <xsl:choose>
                                        <xsl:when test="quantity != 'null' and quantity !=''">
                                            <xsl:value-of select="format-number(quantity, '###,##0')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">

                                <fo:block>
                                    <xsl:value-of select="unitPrice"/>
                                </fo:block>

                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    <xsl:value-of select="amount"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                      border-bottom-width="0.2mm"/>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="6">
                            <fo:block>
                                <xsl:value-of select="'subtotal'"/>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                <xsl:value-of select="subTotal"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>
        <fo:block margin-top="10pt" margin-bottom="5pt" font-weight="bold" font-size="8pt">
            Child Clients
        </fo:block>
        <fo:table width="60%" table-layout="fixed" font-size="8pt" margin-bottom="10pt">
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="30%"/>

            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray" font-weight="bold">
                        <fo:block>Client Name</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray" font-weight="bold">
                        <fo:block>Client Number</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="1mm"
                    text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC - Child Client'"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC-PI-002'"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC - Child Client 2'"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC-PI-003'"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC - Child Client 3'"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm"
                                   text-align="left" border="1pt solid gray">
                        <fo:block>
                            <xsl:value-of select="'SEC-PI-004'"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>

        <fo:block margin-top="10pt" margin-bottom="10pt" font-weight="bold" font-size="8pt">
            Transactions for SEC - Child Client
        </fo:block>
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="27%"/>
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Category</fo:block>
                    </fo:table-cell>
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
                    <fo:table-cell number-columns-spanned="7">
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="categoryDetails-client-1">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block>
                                <xsl:value-of select="categoryName"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="items">
                        <fo:table-row text-align="center">
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <fo:block>
                                    <xsl:value-of select="name"/>
                                </fo:block>
                            </fo:table-cell>
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
                                    <xsl:choose>
                                        <xsl:when test="quantity != 'null' and quantity !=''">
                                            <xsl:value-of select="format-number(quantity, '###,##0')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">

                                <fo:block>
                                    <xsl:value-of select="unitPrice"/>
                                </fo:block>

                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    <xsl:value-of select="amount"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                      border-bottom-width="0.2mm"/>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="6">
                            <fo:block>
                                <xsl:value-of select="'subtotal'"/>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                <xsl:value-of select="subTotal"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>
        <fo:block page-break-before="always">
        </fo:block>
        <fo:block margin-top="10pt" margin-bottom="5pt" font-weight="bold" font-size="8pt">
            Transactions for SEC - Child Client 2
        </fo:block>
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-column column-width="12%"/>
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="27%"/>
            <fo:table-column column-width="15%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-column column-width="9%"/>
            <fo:table-header>
                <fo:table-row font-weight="bold"
                              padding-before="4pt" padding-after="4pt">
                    <fo:table-cell padding-bottom="1mm" padding-top="1mm" text-align="left">
                        <fo:block>Category</fo:block>
                    </fo:table-cell>
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
                    <fo:table-cell number-columns-spanned="7">
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:for-each select="categoryDetails-client-2">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block>
                                <xsl:value-of select="categoryName"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="items">
                        <fo:table-row text-align="center">
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="left">
                                <fo:block>
                                    <xsl:value-of select="name"/>
                                </fo:block>
                            </fo:table-cell>
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
                                    <xsl:choose>
                                        <xsl:when test="quantity != 'null' and quantity !=''">
                                            <xsl:value-of select="format-number(quantity, '###,##0')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">

                                <fo:block>
                                    <xsl:value-of select="unitPrice"/>
                                </fo:block>

                            </fo:table-cell>
                            <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                           text-align="right">
                                <fo:block>
                                    <xsl:value-of select="amount"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="7">
                            <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                      border-bottom-width="0.2mm"/>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="6">
                            <fo:block>
                                <xsl:value-of select="'subtotal'"/>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-bottom="1mm" padding-top="1mm"
                                       text-align="right">
                            <fo:block>
                                <xsl:value-of select="subTotal"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="heading-separator">
        <fo:table width="100%" table-layout="fixed" font-size="8pt">
            <fo:table-body>
                <fo:table-row width="100%">
                    <fo:table-cell number-columns-spanned="7">
                        <fo:block margin-bottom="2pt" margin-top="2pt" border-bottom="solid"
                                  border-bottom-width="0.2mm"/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>