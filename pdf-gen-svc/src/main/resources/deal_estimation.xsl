<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:java="http://xml.apache.org/xslt/java"
                exclude-result-prefixes="fo java">
    <xsl:attribute-set name="body-font">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>

    </xsl:attribute-set>
    <xsl:attribute-set name="heading-font">
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="paragraph-font">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
        <xsl:attribute name="margin-top">12pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
        <xsl:attribute name="text-align">justify</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="sub-paragraph">
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-family">Times New Roman</xsl:attribute>
        <xsl:attribute name="margin-top">12pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">12pt</xsl:attribute>
        <xsl:attribute name="text-align">justify</xsl:attribute>
        <xsl:attribute name="margin-left">30pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="inline-heading">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="border-bottom">solid</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="bold-heading">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="inline-space-heading">
        <xsl:attribute name="padding-left">8pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="underline">
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template match="deal-est">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master
                        master-name="page" page-height="29.7cm" page-width="21.0cm"
                        margin-top="0.80cm" margin-left="2cm" margin-right="2cm"
                        margin-bottom="1.0cm">
                    <fo:region-body margin-top="0.75in"/>
                    <fo:region-before/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="page">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block margin-top="5pt" margin-bottom="5pt">
                        <xsl:call-template name="top-nav"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block margin-top="5pt" margin-bottom="5pt" xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="address-order-form"/>
                    </fo:block>
                    <fo:block margin-top="40pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="address-info"/>
                    </fo:block>
                    <fo:block margin-top="20pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="commercial-terms"/>
                    </fo:block>
                    <fo:block margin-top="20pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="product-details"/>
                    </fo:block>
                    <fo:block break-before="page" margin-top="20pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="nda-section"/>
                    </fo:block>
                    <fo:block break-before="page" margin-top="20pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="subscription-fee-section"/>
                    </fo:block>
                    <fo:block break-before="page" margin-top="20pt" margin-bottom="20pt"
                              xsl:use-attribute-sets="body-font">
                        <xsl:call-template name="additional-details-section"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template name="top-nav">
        <fo:table inline-progression-dimension="auto" table-layout="auto">
            <fo:table-column column-width="100%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell text-align="left">
                        <fo:block margin-top="3pt">
                            <fo:external-graphic
                                    width="0.4in"
                                    height="0.3in" content-height="0.3in"
                                    src="main-logo.png"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="address-order-form">
        <fo:table width="100%" table-layout="fixed">
            <fo:table-column column-width="25%"/>
            <fo:table-column column-width="25%"/>
            <fo:table-column column-width="25%"/>
            <fo:table-column column-width="25%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Akoya LLC
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm">
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-columns-spanned="2" padding="0.5mm" text-align="center">
                        <fo:block font-weight="bold">
                            ORDER FORM
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="3" padding="0.5mm" text-align="left">
                        <fo:block>
                            6 Liberty Sq. #2381
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2" padding="0.5mm" text-align="left">
                        <fo:block>
                            Boston, MA 02109
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="right">
                        <fo:block>
                            Order Date From:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2" padding="0.5mm" text-align="left">
                        <fo:block>
                            <fo:basic-link color="blue" external-destination="http://www.akoya.com">
                                www.akoya.com
                            </fo:basic-link>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="right">
                        <fo:block>
                            Akoya Rep:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>

                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="address-info">
        <fo:table width="100%" table-layout="fixed" margin-top="5pt">
            <fo:table-column column-width="20%"/>
            <fo:table-column column-width="3%"/>
            <fo:table-column column-width="35%"/>
            <fo:table-column column-width="2%"/>
            <fo:table-column column-width="35%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell number-columns-spanned="2" padding="1mm">
                        <fo:block font-weight="bold">Bill To</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block font-weight="bold">Ship To</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>DR Name</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:value-of select="accountDto/name"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>Address</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:for-each select="accountDto/addressList">
                                <xsl:if test="addressType='BILL_TO'">
                                    <xsl:value-of select="line1"/>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>City</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:for-each select="accountDto/addressList">
                                <xsl:if test="addressType='BILL_TO'">
                                    <xsl:value-of select="city"/>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>State</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:for-each select="accountDto/addressList">
                                <xsl:if test="addressType='BILL_TO'">
                                    <xsl:value-of select="state"/>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>Zip</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:for-each select="accountDto/addressList">
                                <xsl:if test="addressType='BILL_TO'">
                                    <xsl:value-of select="zipCode"/>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>Contact Name</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:value-of select="accountDto/contactName"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>Contact Email</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:value-of select="accountDto/contactEmail"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="1mm">
                        <fo:block>Contact Phone</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block>
                            <xsl:value-of select="accountDto/contactPhone"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="1pt solid black" padding="1mm">
                        <fo:block/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="commercial-terms">
        <fo:block xsl:use-attribute-sets="bold-heading" margin-top="20pt" margin-bottom="10pt">
            Commercial Terms:
        </fo:block>
        <fo:table width="100%" table-layout="fixed" border="1pt solid block">
            <fo:table-column column-width="35%" border="1pt solid block"/>
            <fo:table-column column-width="65%" border="1pt solid block"/>
            <fo:table-body>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Billing Method:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            E-mail
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Billing Frequency:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Monthly
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Payment Terms:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Net 30
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Initial Contract Term:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            <xsl:value-of select="contractTerm"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Renewal Terms:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            1 year, auto-renew
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row border="1pt solid block">
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Contract Start:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="0.5mm" text-align="left">
                        <fo:block>
                            Upon Effective Date of corresponding Akoya DAN Data Recipient Subscription Agreement
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template name="nda-section">
        <fo:block xsl:use-attribute-sets="paragraph-font">
            This Order is entered into between DR and Akoya under the Akoya DAN Data Recipient Agreement (the
            “Agreement”) executed between the parties as of the Effective Date, including any addendum entered into by
            the parties, if applicable (collectively, the 'Master Terms'). This Order will be governed by the Master
            Terms and will form part of the Agreement between the parties. Unless otherwise defined in this Order,
            capitalized terms shall have the meanings set forth in the Master Terms.
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            By executing this Order, DR commits to the subscription fee and payments terms set forth above. Each person
            signing this Order represents and warrants that he or she has been duly authorized and has full authority to
            execute this Order on behalf of the party below. This Order may be executed in counterpart, and may be
            executed by way of facsimile or electronic signature, and if so, will be considered an original.
        </fo:block>
        <fo:table width="100%" table-layout="fixed" margin-left="2%" margin-right="2%" margin-top="20pt"
                  margin-bottom="5pt">
            <fo:table-column column-width="46%"/>
            <fo:table-column column-width="4%"/>
            <fo:table-column column-width="46%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding-bottom="2mm" padding-top="2mm" text-align="left" border-top="solid"
                                   border-left="solid" border-width="0.2mm">
                        <fo:block font-weight="bold">
                            AKOYA LLC
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border-top="solid" border-width="0.2mm">
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-bottom="2mm" padding-top="2mm" text-align="left" border-top="solid"
                                   border-right="solid" border-width="0.2mm">
                        <fo:block font-weight="bold">
                            CONNECT FINANCIAL SOFTWARE SOLUTIONS, LLC
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-left="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            By:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-right="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            By:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-left="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Name:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-right="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Name:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-left="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Title:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-right="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Title:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-left="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Date:
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border-bottom="solid" border-width="0.2mm">
                        <fo:block>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding-top="2mm"  border-bottom="solid" border-right="solid"
                                   border-width="0.2mm">
                        <fo:block>
                            Date:
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template name="subscription-fee-section">
        <fo:block text-align="center" margin-bottom="40pt">
            <fo:inline border-bottom="1pt solid black" xsl:use-attribute-sets="heading-font">
                Subscription Fees, Payment, Invoicing
            </fo:inline>
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            Additional terms associated with the Akoya DAN Subscription Fee will be as follows:
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            <fo:inline xsl:use-attribute-sets="inline-heading">Fees.</fo:inline>
            <fo:inline xsl:use-attribute-sets="inline-space-heading">
                DR shall pay Akoya the agreed upon fees as set forth herein (collectively,
                the “<fo:inline xsl:use-attribute-sets="underline">Fees</fo:inline>”). All Fees are
                quoted and payable in US dollars and due within thirty (30) days after DR’s receipt of invoice. If DR
                wishes
                to dispute any invoice in good faith, DR must notify Akoya within ten (10) business days of receipt of
                such
                invoice. If Akoya does not receive written notice within 10 business days of your receipt of the
                invoice, we
                will conclude that you have seen the invoice and find it acceptable. Any disputes regarding such
                invoices
                shall be resolved in the following manner: To the extent that only a portion of an invoice is being
                disputed
                by DR, Akoya may issue an invoice for the undisputed portion of such invoice, and such invoice shall be
                due
                and payable by DR within thirty (30) days after DR’s receipt of the updated invoice. Invoices that are
                unpaid 30 days past the invoice date are deemed delinquent and Akoya reserves the right to charge on the
                past due amount at the lesser of (a) 1.0% per month or (b) the maximum amount permissible by applicable
                law.
                Interest shall accrue from the date that invoice is delinquent. Any amounts due hereunder are exclusive
                of,
                and DR shall be responsible for, all sales taxes, value added taxes, duties, use taxes and withholdings.
                In
                the event that that any collection action is required to collect unpaid balances due to us, DR agrees to
                reimburse Akoya for reasonable costs of collection, including without limitation, attorneys’ fees.
            </fo:inline>
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            <fo:inline xsl:use-attribute-sets="inline-heading">Invoicing.</fo:inline>
            <fo:inline xsl:use-attribute-sets="inline-space-heading">Akoya shall send DR a monthly invoice indicating
                the number of API calls by product and Active
                End User Data Provider Links in the prior month. Akoya DAN Subscription Fees will not be prorated if the
                End
                User Data Provider Link was not active for the entire month. No refunds will be provided after the Akoya
                DAN
                Subscription Fee become billable if the End User Data Provider Link is inactive at any time during the
                prior
                month. No refunds will be provided after the Fees become billable. DR is obligated to pay Akoya all Fees
                and
                expenses that are due, or that become due and payable, during the Term.
            </fo:inline>
        </fo:block>
    </xsl:template>
    <xsl:template name="additional-details-section">
        <fo:block text-align="center" margin-bottom="40pt">
            <fo:inline border-bottom="1pt solid black" xsl:use-attribute-sets="heading-font">
                Additional Product Billing Details
            </fo:inline>
        </fo:block>
        <fo:block xsl:use-attribute-sets="bold-heading">
            Per API
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            Each data request via API (i.e., triggered by a user when they are looking to take an action) will be
            charged a per API fee.
        </fo:block>
        <fo:list-block margin-left="15pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>The per API call (data request) fee is specified in the DR contract with Akoya</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Each Product (API endpoint; e.g. Payments, Balances, Customers, etc) is priced
                        individually and billed on a transactional basis
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block margin-top="20px" margin-bottom="5px">
            Sample applicable use cases:
        </fo:block>
        <fo:list-block margin-left="15pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Account opening</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Lending &amp; credit enhancement</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Payment enablement</fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block margin-bottom="5pt" margin-top="20pt">
            <fo:inline font-weight="bold">Per Link</fo:inline>
            (a.k.a. Per Data Provider “DP” connection)
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            If a DR request data on a recurring or scheduled basis (i.e., on a nightly or weekly refresh of updated or
            new information), Akoya bills on a per DP connection/Link basis.
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            For example, if a DR user authenticates with one DP, the DR is charged on a monthly basis for that one Link.
            Each authentication of a DP through Akoya counts as a Link. See appendix for illustration.
        </fo:block>
        <fo:list-block margin-left="15pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Akoya prices per
                        <fo:inline font-weight="bold">Link per Month</fo:inline>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Each Link represent a connection between Akoya and a DP for a given DR user</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>DRs can access data  <fo:inline font-weight="bold">as many times as</fo:inline> they want
                        for each Link unless capped in the Akoya DAN Data Recipient Subscription Agreement associated
                        with this order
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block margin-top="20px" margin-bottom="5px">
            Sample applicable use cases:
        </fo:block>
        <fo:list-block margin-left="15pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Business financial management</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Personal financial management</fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>Wealth management &amp; investing</fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
        <fo:block xsl:use-attribute-sets="bold-heading" margin-top="20pt" margin-bottom="5pt">
            Billing Rules
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            The following describes the <fo:inline font-weight="bold">generic</fo:inline> Akoya billing logic. Please
            note that any logic provided in the Akoya
            DAN Data Recipient Subscription Agreement between DR and Akoya, if different, will <fo:inline
                font-weight="bold">override
        </fo:inline> the logic
            provided here.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            For the Per API pricing model, Akoya will bill for each successful data request of an API product per month.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            <fo:inline font-weight="bold">Successful</fo:inline>
            is defined as when Akoya returns a successful API response to the DR (i.e., the API responses
            with a 200 success status). Please note that successful API calls might <fo:inline font-weight="bold">not
        </fo:inline> include new data. This is also
            the case if specific data fields are not being returned by the data provider for the selected account.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            For instance, a deposit account may not have regular transactions on it, so a balance check (e.g., Akoya’s
            Balances v2 product) might not return a different value than yesterday as there might not be any new
            transactions. However, it is still a billable API call as it resulted as a 200 success status.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            Akoya does not bill for any <fo:inline font-weight="bold">errors</fo:inline> or <fo:inline
                font-weight="bold">failures.
        </fo:inline> If the API returns an error (e.g., 500 error), the data
            request is not billed
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            Akoya bills for the use of its <fo:inline font-weight="bold">products</fo:inline>. Akoya does not bill for
            the use of supporting APIs provided that
            are required in order to use the Akoya Network.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            Each successful API call for billable products triggers one billing event. Each Akoya product has separate
            pricing sheets and terms as per defined in the contract. Please note that your use case might require
            <fo:inline font-weight="bold">more than one</fo:inline>
            API call to be completed. Each of those API calls are billable.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph">
            For instance, to complete a payment enablement use case, you might need to pull customer information,
            payment network information, and conduct a balance check. This would require doing API calls to three
            billable Akoya products: one API call to the Customers v2 product, one API call to the Payments v2 product,
            and one API call to the Balances v2 product.
        </fo:block>
        <fo:block xsl:use-attribute-sets="bold-heading" margin-top="20pt" margin-bottom="5pt">
            List of Akoya’s billable APIs:
        </fo:block>
        <fo:block margin-bottom="5pt" margin-top="20pt">
            <fo:table border="1pt solid black" width="100%">
                <fo:table-column column-width="20%" border="1pt solid black"/>
                <fo:table-column column-width="20%" border="1pt solid black"/>
                <fo:table-column column-width="50%" border="1pt solid black"/>
                <fo:table-column column-width="10%" border="1pt solid black"/>
                <fo:table-body>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Product Name</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">API Path</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Documentation</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Is Billable?</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <!-- Repeat this block for each row of data -->
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Balances v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/balances/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/get-balances">
                                    https://docs.akoya.com/reference/get-balances
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>Yes</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Investments v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/accounts/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/get-accounts">
                                    https://docs.akoya.com/reference/get-accounts
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>Yes</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Transactions v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/transactions/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/get-transactions">
                                    https://docs.akoya.com/reference/get-transactions
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>Yes</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Payments v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/payments/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/payments">
                                    https://docs.akoya.com/reference/payment-networks
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>Yes</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Customers v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/customers/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/customer-info">
                                    https://docs.akoya.com/reference/customer-info
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>Yes</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block xsl:use-attribute-sets="bold-heading" margin-top="20pt" margin-bottom="5pt">
            Examples of Akoya’s non-billable supporting APIs:
        </fo:block>
        <fo:block margin-bottom="5pt" margin-top="20pt">
            <fo:table border="1pt solid black" width="100%">
                <fo:table-column column-width="20%" border="1pt solid black"/>
                <fo:table-column column-width="20%" border="1pt solid black"/>
                <fo:table-column column-width="50%" border="1pt solid black"/>
                <fo:table-column column-width="10%" border="1pt solid black"/>
                <fo:table-body>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Name</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">API Path</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Documentation</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block font-weight="bold">Is Billable?</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <!-- Repeat this block for each row of data -->
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Balances v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/balances/v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/get-balances">
                                    https://docs.akoya.com/reference/get-balances
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>No</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Accounts Info v2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/accounts-info/v2/</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link external-destination="https://docs.akoya.com/reference/get-accounts-info"
                                               color="blue">
                                    https://docs.akoya.com/reference/get-accounts-info
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>No</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Token</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/token</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/token">
                                    https://docs.akoya.com/reference/token
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>No</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Refresh Token</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/token</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/refresh-token">
                                    https://docs.akoya.com/reference/refresh-token
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>No</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black">
                        <fo:table-cell padding="1mm">
                            <fo:block>Revoke ID Token</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>/token/revoke</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                <fo:basic-link color="blue"
                                               external-destination="https://docs.akoya.com/reference/revoke-token">
                                    https://docs.akoya.com/reference/revoke-token
                                </fo:basic-link>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>No</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font" margin-top="20pt" margin-bottom="5pt">
            For more information about Akoya’s APIs, please consult the <fo:basic-link color="blue"
                                                                                       external-destination="https://docs.akoya.com/">
            documentation
        </fo:basic-link> or reach out to your Customer
            Success Manager.
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph" margin-top="20pt" margin-bottom="5pt">
            Per Link Billing Rules
        </fo:block>
        <fo:block xsl:use-attribute-sets="sub-paragraph" margin-top="20pt" margin-bottom="5pt">
            Per Link pricing model, Akoya will bill for each active link per month.
        </fo:block>
        <fo:list-block margin-left="45pt">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <fo:inline font-weight="bold">Active links are defined as links</fo:inline>
                        for which Akoya registered a successful API call in
                        Month N (please see above, same definitions are applied here).
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                    <fo:block font-weight="bold">•</fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()">
                    <fo:block>
                        <fo:inline font-weight="bold">Inactive links are defined</fo:inline>
                        as links for which Akoya registered a successful API call in
                        Month N-1, or Month N-2, etc., but not in Month N.
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>
    <xsl:template name="product-details">
        <fo:block xsl:use-attribute-sets="bold-heading">
            Products
        </fo:block>

        <xsl:for-each select="dealServiceExportDTOList">
            <xsl:variable name="serviceName" select="serviceName" />
            <xsl:for-each select="rateCards/dimensionPriceList">
                <xsl:variable name="priceUnitLabel" select="priceUnitLabel" />
                <xsl:if test="dimensionPrice/method = 'TIERED'">
                    <xsl:for-each select="dimensionPrice">
                        <fo:table width="100%" table-layout="fixed" margin-top="30pt" margin-bottom="10" border="1pt solid black">
                            <fo:table-column column-width="15%" border="1pt solid black" padding="5pt"/>
                            <fo:table-column column-width="15%" border="1pt solid black" padding="5pt"/>
                            <fo:table-column column-width="15%" border="1pt solid black" padding="5pt"/>
                            <fo:table-column column-width="35%" border="1pt solid black" padding="5pt"/>
                            <fo:table-column column-width="20%" border="1pt solid black" padding="5pt"/>
                            <fo:table-body>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell number-columns-spanned="5" padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="$serviceName"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <fo:table-row border="1pt solid black" padding="5pt" font-weight="bold">
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="'Tier'"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="'Bottom'"/>
                                        </fo:block>
                                    </fo:table-cell >
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="'Top'"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="$priceUnitLabel"/> Tier (Monthly)
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            Price for <xsl:value-of select="$priceUnitLabel"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <xsl:for-each select="priceTiers">
                                    <fo:table-row border="1pt solid black" padding="5pt">
                                        <fo:table-cell padding="5pt">
                                            <fo:block>
                                                <xsl:value-of select="position()"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="5pt">
                                            <fo:block>
                                                <xsl:value-of select="tierStart"/>
                                            </fo:block>
                                        </fo:table-cell >
                                        <fo:table-cell padding="5pt">
                                            <fo:block>
                                                <xsl:value-of select="tierEnd"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="5pt">
                                            <fo:block>
                                                From <xsl:value-of select="tierStart"/> to <xsl:value-of select="tierEnd"/>
                                                <xsl:text> </xsl:text><xsl:value-of select="$priceUnitLabel"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="5pt" text-align="right">
                                            <fo:block>
                                                $ <xsl:value-of select="unitPrice"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="dimensionPrice/method = 'QUANTITY'">
                    <xsl:for-each select="dimensionPrice">
                        <fo:table width="60%" table-layout="fixed" margin-top="30pt" margin-bottom="10" border="1pt solid black">
                            <fo:table-column column-width="40%" border="1pt solid black" padding="5pt"/>
                            <fo:table-column column-width="40%" border="1pt solid black" padding="5pt"/>
                            <fo:table-body>
                                <fo:table-row font-weight="bold">
                                    <fo:table-cell padding="5pt" number-columns-spanned="2">
                                        <fo:block>
                                            <xsl:value-of select="$serviceName"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>

                                <fo:table-row border="1pt solid black" padding="5pt" font-weight="bold">
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="'Label'"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="'Unit Price'"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                                <fo:table-row border="1pt solid black" padding="5pt">
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            <xsl:value-of select="$priceUnitLabel"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt">
                                        <fo:block>
                                            $ <xsl:value-of select="unitPrice"/>
                                        </fo:block>
                                    </fo:table-cell >
                                </fo:table-row>

                            </fo:table-body>
                        </fo:table>
                    </xsl:for-each>
                </xsl:if>

            </xsl:for-each>

        </xsl:for-each>

        <fo:block xsl:use-attribute-sets="paragraph-font">
            The Akoya DAN Subscription Fee consists of Volume Fees set forth below based on the number of successful API
            calls a DR requests and/or the number Active Links in a given month.
        </fo:block>
        <fo:block xsl:use-attribute-sets="bold-heading">
            Minimum Volume Fees:
        </fo:block>
        <fo:block xsl:use-attribute-sets="paragraph-font">
            The following monthly fees will be billed as a credit towards per-API call Fees.
        </fo:block>
        <fo:block margin-bottom="5pt" margin-top="20pt">
            <fo:table width="60%" table-layout="fixed" border="1pt solid black">
                <fo:table-column column-width="20%" border="1pt solid black"/>
                <fo:table-column column-width="40%" border="1pt solid black"/>
                <fo:table-body>
                    <fo:table-row border="1pt solid black" padding="1mm" font-weight="bold">
                        <fo:table-cell padding="1mm">
                            <fo:block>Year</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm">
                            <fo:block>
                                Monthly Minimum
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black" padding="1mm">
                        <fo:table-cell padding="1mm">
                            <fo:block>1</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm" text-align="right">
                            <fo:block>
                                $5,000.00
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black" padding="1mm">
                        <fo:table-cell padding="1mm">
                            <fo:block>2</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm" text-align="right">
                            <fo:block>
                                $10,000.00
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border="1pt solid black" padding="1mm">
                        <fo:table-cell padding="1mm">
                            <fo:block>3+</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="1mm" text-align="right">
                            <fo:block>
                                $15,000.00
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>