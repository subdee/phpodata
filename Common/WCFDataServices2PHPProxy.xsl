<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:edmx="http://schemas.microsoft.com/ado/2007/06/edmx"
	xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices"
	xmlns:schema_1_0="http://schemas.microsoft.com/ado/2006/04/edm"
	xmlns:schema_1_1="http://schemas.microsoft.com/ado/2007/05/edm"
	xmlns:schema_1_2="http://schemas.microsoft.com/ado/2008/09/edm"
	xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata">

	<xsl:output method="text"/>
		<!-- Default service URI passed externally -->
	<xsl:param name="DefaultServiceURI"/>
	<xsl:template match="/">&lt;?php
/*
	Copyright 2010 Persistent Systems Limited
	
	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at
	
	http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

/**
 * This code was generated by the tool 'PHPDataSvcUtil.php'.
 * Runtime Version:1.0
 *
 * Changes to this file may cause incorrect behavior and will be lost if
 * the code is regenerated.
 */

// assume the PHP OData library is in a PHP include path
require_once 'OData/Context/ObjectContext.php';
<xsl:apply-templates select="/edmx:Edmx/edmx:DataServices/schema_1_0:Schema | /edmx:Edmx/edmx:DataServices/schema_1_1:Schema | /edmx:Edmx/edmx:DataServices/schema_1_2:Schema"/>
</xsl:template>

	<xsl:template match="/edmx:Edmx/edmx:DataServices/schema_1_0:Schema | /edmx:Edmx/edmx:DataServices/schema_1_1:Schema | /edmx:Edmx/edmx:DataServices/schema_1_2:Schema">
		<xsl:apply-templates select="schema_1_0:EntityContainer | schema_1_1:EntityContainer | schema_1_2:EntityContainer"/>
		<xsl:for-each select="schema_1_0:EntityType | schema_1_1:EntityType | schema_1_2:EntityType">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
		<xsl:for-each select="schema_1_0:ComplexType | schema_1_1:ComplexType | schema_1_2:ComplexType">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:template>

	<!-- Generate container class -->
	<xsl:template match="schema_1_0:EntityContainer | schema_1_1:EntityContainer | schema_1_2:EntityContainer">
		<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
		<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
		<xsl:variable name="service_namespace_1" select="concat(//schema_1_0:EntityType/../@Namespace, //schema_1_1:EntityType/../@Namespace)" />
		<xsl:variable name="service_namespace" select="concat($service_namespace_1, //schema_1_2:EntityType/../@Namespace)" />
/**
 * Container class <xsl:value-of select="@Name"/>
 * OData Service Namespace: <xsl:value-of select="$service_namespace"/>
 */
class <xsl:value-of select="@Name"/>
	extends ObjectContext {

	const DEFAULT_ODATA_SERVICE_URL = '<xsl:value-of select="$DefaultServiceURI"/>';
<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
	protected $_<xsl:value-of select="@Name"/>;</xsl:for-each>

/**
 * The constructor for <xsl:value-of select="@Name"/> accepting service URI
 */
	public function __construct($uri = '') {
		if (strlen($uri) == 0) {
			$uri = self::DEFAULT_ODATA_SERVICE_URL;
		}

		if (Utility::reverseFind($uri, '/') != strlen($uri) - 1) {
			$uri = $uri . '/';
		}

		$this->_baseURI = $uri;
		parent::__construct($this->_baseURI);
		
		$this->_entities = array(<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
			'<xsl:value-of select="@Name"/>'<xsl:if test="position() != last()">,</xsl:if>
</xsl:for-each>
		);
		
		$this->_entitySet2Type = array(<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
			'<xsl:value-of select="translate(@Name, $uppercase, $smallcase)" />' =&gt; '<xsl:value-of select="substring-after(@EntityType, concat($service_namespace, '.'))"/>'<xsl:if test="position() != last()">,</xsl:if>
</xsl:for-each>
		);
		
		$this->_entityType2Set = array(<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
			'<xsl:value-of select="translate(substring-after(@EntityType, concat($service_namespace, '.')), $uppercase, $smallcase)" />' =&gt; '<xsl:value-of select="@Name"/>'<xsl:if test="position() != last()">,</xsl:if>
</xsl:for-each>
		);

		$this->_association = array(<xsl:for-each select="/edmx:Edmx/edmx:DataServices/schema_1_0:Schema/schema_1_0:Association | /edmx:Edmx/edmx:DataServices/schema_1_1:Schema/schema_1_1:Association | /edmx:Edmx/edmx:DataServices/schema_1_2:Schema/schema_1_2:Association">
			'<xsl:value-of select="@Name"/>' =&gt; array(<xsl:for-each select="schema_1_0:End | schema_1_1:End | schema_1_2:End">
				'<xsl:value-of select="@Role"/>' =&gt; '<xsl:value-of select="@Multiplicity"/>'<xsl:if test="position() != last()">,</xsl:if>
			</xsl:for-each>)<xsl:if test="position() != last()">,</xsl:if>
</xsl:for-each>
		);

<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
		$this-&gt;_<xsl:value-of select="@Name"/> = new DataServiceQuery('/<xsl:value-of select="@Name"/>', $this);</xsl:for-each>
	}
<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
	/**
	 * Function returns DataServiceQuery reference for the entityset
	 * <xsl:value-of select="@Name"/>
	 * @return DataServiceQuery
	 */
	public function <xsl:value-of select="@Name"/>() {
		$this->_<xsl:value-of select="@Name"/>->ClearAllOptions();
		return $this->_<xsl:value-of select="@Name"/>;
	}
</xsl:for-each>
	/**
	 * Functions for adding object to the entityset/collection
	 */
<xsl:for-each select="schema_1_0:EntitySet | schema_1_1:EntitySet | schema_1_2:EntitySet">
	/**
	 * Add <xsl:value-of select="@Name"/>
	 * @param <xsl:value-of select="@Name"/> $object
	 */
	public function addTo<xsl:value-of select="@Name"/>($object) {
		return parent::AddObject('<xsl:value-of select="@Name"/>', $object);
	}
</xsl:for-each>
	/**
	 * This function returns the entities.
	 */
	public function getEntities() {
		return $this->_entities;
	}
}
</xsl:template>

	<xsl:template match="schema_1_0:EntityType |schema_1_1:EntityType |schema_1_2:EntityType">
		<xsl:variable name="service_namespace_1" select="concat(//schema_1_0:EntityType/../@Namespace, //schema_1_1:EntityType/../@Namespace)" />
		<xsl:variable name="service_namespace" select="concat($service_namespace_1, //schema_1_2:EntityType/../@Namespace)" />
/**
 * @class:<xsl:value-of select="@Name"/>
 * @type:EntityType<xsl:for-each select="schema_1_0:Key | schema_1_1:Key | schema_1_2:Key">
<xsl:for-each select="schema_1_0:PropertyRef | schema_1_1:PropertyRef | schema_1_2:PropertyRef">
 * @key:<xsl:value-of select="@Name"/>
</xsl:for-each>
</xsl:for-each>
<xsl:if test="@m:FC_SourcePath">
 * @FC_SourcePath:<xsl:value-of select="@m:FC_SourcePath"/>
 * @FC_TargetPath:<xsl:value-of select="@m:FC_TargetPath"/>
 * @FC_ContentKind:<xsl:value-of select="@m:FC_ContentKind"/>
 * @FC_KeepInContent:<xsl:value-of select="@m:FC_KeepInContent"/>
</xsl:if>
 */
class <xsl:value-of select="@Name"/>
	extends Object {

	protected $_entityMap = array();
	protected $_entityKey = array();
	protected $_relLinks  = array();
	protected $_baseURI;
<xsl:for-each select="schema_1_0:Property | schema_1_1:Property | schema_1_2:Property">
	/**
	 * @Type:EntityProperty<xsl:if test="@Nullable = 'false'">
	 * NotNullable</xsl:if>
	 * @EdmType:<xsl:value-of select="@Type"/><xsl:if test="@Type = 'Edm.String'">
	 * @MaxLength:<xsl:value-of select="@MaxLength"/>
	 * @FixedLength:<xsl:value-of select="@FixedLength"/>
</xsl:if>
<xsl:if test="@m:FC_TargetPath">
	 * @FC_TargetPath:<xsl:value-of select="@m:FC_TargetPath"/>
	 * @FC_ContentKind:<xsl:value-of select="@m:FC_ContentKind"/>
	 * @FC_NsPrefix:<xsl:value-of select="@m:FC_NsPrefix"/>
	 * @FC_NsUri:<xsl:value-of select="@m:FC_NsUri"/>
	 * @FC_KeepInContent:<xsl:value-of select="@m:FC_KeepInContent"/>
</xsl:if>
	 */
	public $<xsl:value-of select="@Name"/>;
</xsl:for-each>
<xsl:for-each select="schema_1_0:NavigationProperty | schema_1_1:NavigationProperty | schema_1_2:NavigationProperty">
	/**
	 * @Type:NavigationProperty
	 * @Relationship:<xsl:value-of select="substring-after(@Relationship, concat($service_namespace, '.'))"/>
	 * @FromRole:<xsl:value-of select="@FromRole"/>
	 * @ToRole:<xsl:value-of select="@ToRole"/>
	 */
	public $<xsl:value-of select="@Name"/>;
</xsl:for-each>
	/**
	 * Function to create an instance of <xsl:value-of select="@Name"/>
<xsl:for-each select="schema_1_0:Property[@Nullable = 'false'] | schema_1_1:Property[@Nullable = 'false'] | schema_1_2:Property[@Nullable = 'false']">
	 * @param <xsl:value-of select="@Type"/> $<xsl:value-of select="@Name"/>
</xsl:for-each>
	 */
	public static function create<xsl:value-of select="@Name"/>(<xsl:for-each select="schema_1_0:Property[@Nullable = 'false'] | schema_1_1:Property[@Nullable = 'false'] | schema_1_2:Property[@Nullable = 'false']">
		$<xsl:value-of select="@Name"/><xsl:if test="position() != last()">, </xsl:if>
</xsl:for-each>
	) {<xsl:variable name="ClassName" select="@Name"/>
		$<xsl:value-of select="@Name"/> = new <xsl:value-of select="@Name"/>();<xsl:for-each select="schema_1_0:Property[@Nullable = 'false'] | schema_1_1:Property[@Nullable = 'false'] | schema_1_2:Property[@Nullable = 'false']">
		$<xsl:value-of select="$ClassName"/>-><xsl:value-of select="@Name"/> = $<xsl:value-of select="@Name"/>;</xsl:for-each>
		return $<xsl:value-of select="@Name"/>;
	}

	/**
	 * Constructor for <xsl:value-of select="@Name"/>
	 */
	public function __construct($uri = '') {
		$this->_objectID = Guid::NewGuid();
		$this->_baseURI = $uri;
<xsl:for-each select="schema_1_0:NavigationProperty | schema_1_1:NavigationProperty | schema_1_2:NavigationProperty">
		$this->_entityMap['<xsl:value-of select="@Name"/>'] = '<xsl:value-of select="@ToRole"/>';</xsl:for-each>
<xsl:apply-templates select="schema_1_0:Key | schema_1_1:Key"/>
<xsl:for-each select="schema_1_0:NavigationProperty | schema_1_1:NavigationProperty | schema_1_2:NavigationProperty">
		$this-><xsl:value-of select="@Name"/> = array();</xsl:for-each>
	}

	/**
	 * overring getObjectID() functon of Object class
	 */
	public function getObjectID() {
		return $this->_objectID;
	}

	/**
	 * This function returns the entity keys of this entity.
	 */
	public function getEntityKeys() {
		return $this->_entityKey;
	}

	/**
	 * This function set the entity keys of this entity.
	 */
	public function setEntityKeys($entityKey) {
		$this->_entityKey = $entityKey;
	}

	/**
	 * This function returns the related links of this entity.
	 */
	public function getRelatedLinks() {
		return $this->_relLinks;
	}

	/**
	 * This function set the related links of this entity.
	 */
	public function setRelatedLinks($relLinks) {
		$this->_relLinks = $relLinks;
	}

	/**
	 * Function for getting Entity Type Name corrosponding to navigation Name
	 */
	public function getActualEntityTypeName($key) {
		if (array_key_exists($key, $this->_entityMap)) {
			return ($this->_entityMap[$key]);
		}
		return $key;
	}
}
</xsl:template>

	<xsl:template match="schema_1_0:ComplexType |schema_1_1:ComplexType |schema_1_2:ComplexType">
		<xsl:variable name="service_namespace_1" select="concat(//schema_1_0:ComplexType/../@Namespace, //schema_1_1:ComplexType/../@Namespace)" />
		<xsl:variable name="service_namespace" select="concat($service_namespace_1, //schema_1_2:ComplexType/../@Namespace)" />
/**
 * @class:<xsl:value-of select="@Name"/>
 * @type:ComplexType
 */
class <xsl:value-of select="@Name"/> {
		<xsl:for-each select="schema_1_0:Property | schema_1_1:Property | schema_1_2:Property">
	/**
	 * @Type:EntityProperty<xsl:if test="@Nullable = 'false'">
	 * NotNullable</xsl:if>
	 * @EdmType:<xsl:value-of select="@Type"/><xsl:if test="@Type = 'Edm.String'">
	 * @MaxLength:<xsl:value-of select="@MaxLength"/>
	 * @FixedLength:<xsl:value-of select="@FixedLength"/>
			</xsl:if>
	 */
	public $<xsl:value-of select="@Name"/>;
</xsl:for-each>
}
	</xsl:template>

	<xsl:template match="schema_1_0:Key | schema_1_1:Key | schema_1_2:Key">
		<xsl:for-each select="schema_1_0:PropertyRef | schema_1_1:PropertyRef | schema_1_2:PropertyRef">
		$this->_entityKey[] = '<xsl:value-of select="@Name"/>';</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
