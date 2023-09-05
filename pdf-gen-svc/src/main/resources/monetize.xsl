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

					<fo:block text-align="right" margin-top="5pt"
							  margin-right="0.7in" font-size="10pt">
						<fo:inline font-size="10pt">Page</fo:inline>
						<xsl:text>  </xsl:text>
						<fo:inline>
							<fo:page-number/>
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
					<fo:table-cell>
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
			<fo:block>
				<xsl:value-of select="account/name"/>
			</fo:block>
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
		<fo:table width="95%" table-layout="fixed" font-size="7pt"
				  margin-left="1mm" margin-top="5mm">
			<fo:table-column column-width="80%"/>
			<fo:table-column column-width="15%"/>

			<fo:table-header>
				<fo:table-row height="20pt"
				>
					<fo:table-cell background-color="#ddeaf5" border-top="1px solid gray" border-left="1px solid gray"
								   border-bottom="1px solid gray">
						<fo:block xsl:use-attribute-sets="margin_left"
								  margin-top="2pt" font-size="7pt" text-align="left" padding-left="1in">
							<fo:inline>DESCRIPTION</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell background-color="#ddeaf5" border-top="1px solid gray" border-right="1px solid gray"
								   border-bottom="1px solid gray">
						<fo:block xsl:use-attribute-sets="margin_left"
								  margin-top="2pt" font-size="7pt" text-align="left">
							<fo:inline>AMOUNT</fo:inline>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>

			</fo:table-header>
			<fo:table-body>
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
				<xsl:for-each select="billItems">
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
				</xsl:for-each>
				<xsl:if test="adjustmentList">
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
				</xsl:for-each>
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
					<fo:table-cell border-top="1px solid gray">
						<fo:block xsl:use-attribute-sets="margin_left"
								  margin-top="2pt" font-size="7pt" text-align="right">
							<fo:inline>TOTAL (USD)</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell border="1px solid gray">
						<fo:block margin-top="2pt" font-size="7pt" text-align="right">
							$<xsl:value-of select="format-number(balance, '###,##0.00')"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>

		</fo:table>
	</xsl:template>
	<xsl:template name="header_with_address_invoice_details">
		<fo:table width="100%" table-layout="fixed" font-size="7pt"
				  margin-left="-2mm">
			<fo:table-column column-width="30%"/>
			<fo:table-column column-width="20%"/>
			<fo:table-column column-width="50%"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell padding="1mm">
						<fo:table font-size="7pt">
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
									<fo:table-cell padding="1mm">
										<fo:block>
											Client One Inc.
										</fo:block>
										<fo:block>
											California Street
										</fo:block>
										<fo:block>
											San Francisco CA 12345
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
						<fo:table width="100%" table-layout="fixed"
								  font-size="7pt">
							<fo:table-column column-width="60%"/>
							<fo:table-column column-width="40%"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right">INVOICE# :</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm">
											<xsl:value-of select="invoiceNo"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right">DATE :</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm">
											<xsl:value-of select="dateStr"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right">AE# :</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm">
											<xsl:value-of select="account/accountNo"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right">PO :</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm"></fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right">TEAM NAME :</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm"></fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-align="right"></fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-align="left" margin-left="-4mm"></fo:block>
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
										<fo:block text-align="left" margin-left="-4mm">NET 30
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
			<fo:external-graphic
					width="0.5in"
					height="0.4in" content-height="0.4in"
					src="main-logo.png" />
		</fo:inline>
		<fo:table width="81%" font-size="10pt" table-layout="fixed">
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-size="14pt" font-weight="bold"
								  text-align="right" margin-right="0.2in">
							<fo:inline>INVOICE</fo:inline>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template name="customer_address">
		<fo:table width="100%" table-layout="fixed" font-size="7pt"
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
		</fo:table>
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