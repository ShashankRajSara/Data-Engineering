
1. *COMPUTE IN THE CLOUD*


- **Amazon Elastic Compute Cloud (Amazon EC2)** offers the broadest and deepest compute platform, with over
    500 instances and choice of the latest processor, storage, networking, operating system, and purchase model
     to help you best match the needs of your workload.

- **Amazon EC2** provides a wide selection of *instance* types optimized to fit different use cases. Instance types 
    comprise varying combinations of CPU, memory, storage, and networking capacity and give you the flexibility to 
    choose the appropriate mix of resources for your applications. Each instance type includes one or more instance sizes, 
    allowing you to scale your resources to the requirements of your target workload.

    - **General purpose** instances provide a balance of compute, memory and networking resources, and can be used for a variety of diverse workloads. These instances are ideal for applications that use these resources in equal proportions such as web servers and code repositories. 

    - **Compute Optimized** instances are ideal for compute bound applications that benefit from high performance processors. Instances belonging to this family are well suited for batch processing workloads, media transcoding, high performance web servers, high performance computing (HPC), scientific modeling, dedicated gaming servers and ad server engines, machine learning inference and other compute intensive applications.

    - **Memory optimized** instances are designed to deliver fast performance for workloads that process large data sets in memory.

    - **Accelerated computing** instances use hardware accelerators, or co-processors, to perform functions, such as floating point number calculations, graphics processing, or data pattern matching, more efficiently than is possible in software running on CPUs.

    - **Storage optimized** instances are designed for workloads that require high, sequential read and write access to very large data sets on local storage. They are optimized to deliver tens of thousands of low-latency, random I/O operations per second (IOPS) to applications.

- **Pricing**:
    - **On-Demand Instances** are ideal for short-term, irregular workloads that cannot be interrupted. No upfront costs or minimum contracts apply. The instances run continuously until you stop them, and you pay for only the compute time you use. 
    Sample use cases for On-Demand Instances include developing and testing applications and running applications that have unpredictable usage patterns. On-Demand Instances are not recommended for workloads that last a year or longer because these workloads can experience greater cost savings using Reserved Instances.

    - AWS offers **Savings Plans** for several compute services, including Amazon EC2. Amazon EC2 Savings Plans enable you to reduce your compute costs by committing to a consistent amount of compute usage for a 1-year or 3-year term. 
    This term commitment results in savings of up to 72% over On-Demand costs.

    - **Reserved Instances** are a billing discount applied to the use of On-Demand Instances in your account. You can purchase Standard Reserved and Convertible Reserved Instances for a 1-year or 3-year term, and Scheduled Reserved Instances for a 1-year term. You realize greater cost savings with the 3-year option.

    - **Spot Instances** are ideal for workloads with flexible start and end times, or that can withstand interruptions. Spot Instances use unused Amazon EC2 computing capacity and offer you cost savings at up to 90% off of On-Demand prices.

    - **Dedicated Hosts** are physical servers with Amazon EC2 instance capacity that is fully dedicated to your use. 
    Of all the Amazon EC2 options that were covered, Dedicated Hosts are the most expensive.

- **Elastic Load Balancing** is the AWS service that automatically distributes incoming application traffic 
    across multiple resources, such as Amazon EC2 instances. This helps to ensure that no single resource 
    becomes overutilized.
    
- A **Load balancer** acts as a single point of contact for all incoming web traffic to your Auto Scaling group. This means that as 
    you add or remove Amazon EC2 instances in response to the amount of incoming traffic, these requests route to the load balancer first. Then, the requests spread across multiple resources that will handle them. For example, if you have multiple Amazon EC2 instances, Elastic Load Balancing distributes the workload across the multiple instances so that no single instance has to carry the bulk of it.
    Although Elastic Load Balancing and Amazon EC2 Auto Scaling are separate services, they work together to help ensure that applications running in Amazon EC2 can provide high performance and availability. 

- **Amazon EKS** is a fully managed Kubernetes service. 
    Kubernetes is open-source software that enables you to deploy and manage containerized 
    applications at scale.

- **AWS Lambda** is a service that lets you run code without provisioning or managing servers.
    While using AWS Lambda, you pay only for the compute time that you consume. Charges apply only when your code is running. You can also run code for virtually any type of application or backend service, all with zero administration. 

- **Amazon Simple Queue Service (Amazon SQS)** is a service that enables you to send, store, and 
    receive messages between software components through a queue.

- **Amazon Simple Notification Service (Amazon SNS)** is a publish/subscribe service. Using Amazon 
    SNS topics, a publisher publishes messages to subscribers.

- **AWS Fargate** is a serverless compute engine for containers. It works with both Amazon ECS and Amazon EKS. 
    When using AWS Fargate, you do not need to provision or manage servers. AWS Fargate manages your server infrastructure for you. You can focus more on innovating and developing your applications, and you pay only for the resources that are required to run your containers.

==============================
*GLOBAL INFRASTRUCTURE*
==============================

- **Selecting a Region:**
    - *Compliance with data governance and legal requirements:*
        Depending on your company and location, you might need to run your data out of specific areas. For example, if your company requires all of its data to reside within the boundaries of the UK, you would choose the London Region.Not all companies have location-specific data regulations, so you might need to focus more on the other three factors.

    - *Proximity to Customers:*
        - Selecting a Region that is close to your customers will help you to get content to them faster. For example, your company is based in Washington, DC, and many of your customers live in Singapore. You might consider running your infrastructure in the Northern Virginia Region to be close to company headquarters, and run your applications from the Singapore Region.
    
    - *Available services within a region:*
        - Sometimes, the closest Region might not have all the features that you want to offer to customers. AWS is frequently innovating by creating new services and expanding on features within existing services. However, making new services available around the world sometimes requires AWS to build out physical hardware one Region at a time.  

    - *Pricing:*
        - Suppose that you are considering running applications in both the United States and Brazil. The way Brazil’s tax structure is set up, it might cost 50% more to run the same workload out of the São Paulo Region compared to the Oregon Region. You will learn in more detail that several factors determine pricing, but for now know that the cost of services can vary from Region to Region.

- An **Availability Zone** is a single data center or a group of data centers within a Region. Availability Zones are located tens of
     miles apart from each other. This is close enough to have low latency (the time between when content requested and received) between Availability Zones. However, if a disaster occurs in one part of the Region, they are distant enough to reduce the chance that multiple Availability Zones are affected.

- An **Edge location** is a site that Amazon CloudFront uses to store cached copies of your content closer to your customers for 
    faster delivery.

- **Amazon CloudFront** is a content delivery service. It uses a network of edge locations to cache content and deliver content 
    to customers all over the world. When content is cached, it is stored locally as a copy. This content might be video files, photos, webpages, and so on.

- **AWS Interaction:**
    - The **AWS Management Console** is a web-based interface for accessing and managing AWS services. You can quickly access recently used services and search for other services by name, keyword, or acronym. The console includes wizards and automated workflows that can simplify the process of completing tasks.

    - **AWS CLI** => To save time when making API requests, you can use the AWS Command Line Interface (AWS CLI). AWS CLI enables you to control multiple AWS services directly from the command line within one tool. AWS CLI is available for users on Windows, macOS, and Linux. 

    - **AWS SDKs** => SDKs make it easier for you to use AWS services through an API designed for your programming language or platform. SDKs enable you to use AWS services with your existing applications or create entirely new applications that will run on AWS.

    - **AWS Elastic Beanstalk:**
        With AWS Elastic Beanstalk, you provide code and configuration settings, and Elastic Beanstalk deploys the resources necessary to perform the following tasks:
            - Adjust capacity
            - Load balancing
            - Automatic scaling
            - Application health monitoring

    - **AWS CloudFormation:**
        - With AWS CloudFormation, you can treat your infrastructure as code. This means that you can build an environment by writing lines of code instead of using the AWS Management Console to individually provision resources.
        - AWS CloudFormation provisions your resources in a safe, repeatable manner, enabling you to frequently build your infrastructure and applications without having to perform manual actions. It determines the right operations to perform when managing your stack and rolls back changes automatically if it detects errors.


=========================
    NETWORKING
=========================

- **Amazon VPC** enables you to provision an isolated section of the AWS Cloud. In this isolated section, you can launch resources in a virtual network that you define. Within a virtual private cloud (VPC), you can organize your resources into subnets. A subnet is a section of a VPC that can contain resources such as Amazon EC2 instances.

- **Internet Gateway** - To allow public traffic from the internet to access your VPC, you attach an internet gateway to the VPC. An internet gateway is a connection between a VPC and the internet. You can think of an internet gateway as being similar to a doorway that customers use to enter the coffee shop. Without an internet gateway, no one can access the resources within your VPC.

- A **virtual private gateway** enables you to establish a virtual private network (VPN) connection between your VPC and a private network, such as an on-premises data center or internal corporate network. A virtual private gateway allows traffic into the VPC only if it is coming from an approved network.

- **AWS Direct Connect** is a service that enables you to establish a dedicated private connection between your data center and a VPC. The private connection that AWS Direct Connect provides helps you to reduce network costs and increase the amount of bandwidth that can travel through your network. *Private Optical cable to Amazon Data Center*  

- A **subnet** is a section of a VPC in which you can group resources based on security or operational needs. Subnets can be public or private.
- Public subnets contain resources that need to be accessible by the public, such as an online store’s website.
- Private subnets contain resources that should be accessible only through your private network, such as a database that contains customers’ personal information and order histories. 

- A ***network access control list (ACL)*** is a virtual firewall that controls inbound and outbound traffic at the subnet level.

- **Stateless packet filtering** - Network ACLs perform stateless packet filtering. They remember nothing and check packets that 
    cross  the subnet border each way: inbound and outbound. 

- **Security groups** - A security group is a virtual firewall that controls inbound and outbound traffic for an Amazon EC2 instance.

- **Stateful packet filtering** -  Security groups perform stateful packet filtering. They remember previous decisions made for 
    incoming packets.

- **Amazon Route 53** is a DNS web service. It gives developers and businesses a reliable way to route end users to internet 
    applications hosted in AWS. Amazon Route 53 connects user requests to infrastructure running in AWS (such as Amazon EC2 instances and load balancers). It can route users to infrastructure outside of AWS.


===================
- **Strorage**
===================

- **Amazon Elastic Block Store** (Amazon EBS) is a service that provides block-level storage volumes that you can use with 
    Amazon EC2 instances. If you stop or terminate an Amazon EC2 instance, all the data on the attached EBS volume remains available. Because EBS volumes are for data that needs to persist, it’s important to back up the data. You can take incremental backups of EBS volumes by creating *Amazon EBS snapshots*.
    
- An *EBS snapshot* is an incremental backup. This means that the first backup taken of a volume copies all the data. For subsequent
     backups, only the blocks of data that have changed since the most recent snapshot are saved. Incremental backups are different from full backups, in which all the data in a storage volume copies each time a backup occurs. The full backup includes data that has not changed since the most recent backup.

- In *object storage*, each object consists of data, metadata, and a key.The data might be an image, video, text document, or any other type of file. Metadata contains information about what the data is, how it is used, the object size, and so on. An object’s key is its unique identifier.

- *Amazon Simple Storage Service (Amazon S3)*:
    - Amazon Simple Storage Service (Amazon S3) is a service that provides object-level storage. Amazon S3 stores data as objects in buckets.
    - You can upload any type of file to Amazon S3, such as images, videos, text files, and so on. For example, you might use Amazon S3 to store backup files, media files for a website, or archived documents. Amazon S3 offers unlimited storage space. The maximum file size for an object in Amazon S3 is 5 TB.
    - When you upload a file to Amazon S3, you can set permissions to control visibility and access to it. You can also use the Amazon S3 versioning feature to track changes to your objects over time.

- *Amazon S3 storage classes:*
    - With Amazon S3, you pay only for what you use. You can choose from a range of storage classes to select a fit for your business and cost needs. When selecting an Amazon S3 storage class, consider these two factors:
        - How often you plan to retrieve your data
        - How available you need your data to be

- Amazon S3 Standard:
    - Amazon S3 Standard provides high availability for objects. This makes it a good choice for a wide range of use cases, such as websites, content distribution, and data analytics. Amazon S3 Standard has a higher cost than other storage classes intended for infrequently accessed data and archival storage.

- Amazon S3 Standard-Infrequent Access (S3 Standard-IA):
    - Amazon S3 Standard-IA is ideal for data infrequently accessed but requires high availability when needed. Both Amazon S3 Standard and Amazon S3 Standard-IA store data in a minimum of three Availability Zones. Amazon S3 Standard-IA provides the same level of availability as Amazon S3 Standard but with a lower storage price and a higher retrieval price.

- Amazon S3 One Zone-Infrequent Access (S3 One Zone-IA):
    - Compared to Amazon S3 Standard and Amazon S3 Standard-IA, which store data in a minimum of three Availability Zones, Amazon S3 One Zone-IA stores data in a single Availability Zone. This makes it a good storage class to consider if the following conditions apply:

- Amazon S3 Intelligent-Tiering:
    - In the Amazon S3 Intelligent-Tiering storage class, Amazon S3 monitors objects’ access patterns. If you haven’t accessed an object for 30 consecutive days, Amazon S3 automatically moves it to the infrequent access tier, Amazon S3 Standard-IA. If you access an object in the infrequent access tier, Amazon S3 automatically moves it to the frequent access tier, Amazon S3 Standard.

- Amazon S3 Glacier Instant Retrieval:
    - When you decide between the options for archival storage, consider how quickly you must retrieve the archived objects. You can retrieve objects stored in the Amazon S3 Glacier Instant Retrieval storage class within milliseconds, with the same performance as Amazon S3 Standard.

- Amazon S3 Glacier Flexible Retrieval:
    - Amazon S3 Glacier Flexible Retrieval is a low-cost storage class that is ideal for data archiving. For example, you might use this storage class to store archived customer records or older photos and video files.

- Amazon S3 Glacier Deep Archive:
    - Amazon S3 Deep Archive supports long-term retention and digital preservation for data that might be accessed once or twice in a year. This storage class is the lowest-cost storage in the AWS Cloud, with data retrieval from 12 to 48 hours. All objects from this storage class are replicated and stored across at least three geographically dispersed Availability Zones.

- Amazon S3 Outposts: 
    - Amazon S3 Outposts delivers object storage to your on-premises AWS Outposts environment. Amazon S3 Outposts is designed to store data durably and redundantly across multiple devices and servers on your Outposts. It works well for workloads with local data residency requirements that must satisfy demanding performance needs by keeping data close to on-premises applications.

- Compared to block storage and object storage, file storage is ideal for use cases in which a large number of services and resources need to access the same data at the same time.

- *Amazon Elastic File System* (Amazon EFS) is a scalable file system used with AWS Cloud services and on-premises resources. As you add and remove files, Amazon EFS grows and shrinks automatically. It can scale on demand to petabytes without disrupting applications. 

- *Amazon Relational Database Service*:
    - Amazon Relational Database Service (Amazon RDS) is a service that enables you to run relational databases in the AWS Cloud.
    - Amazon RDS is a managed service that automates tasks such as hardware provisioning, database setup, patching, and backups. With these capabilities, you can spend less time completing administrative tasks and more time using data to innovate your applications. You can integrate Amazon RDS with other services to fulfill your business and operational needs, such as using AWS Lambda to query your database from a serverless application.

- *Amazon Aurora*:
    - Amazon Aurora is an enterprise-class relational database. It is compatible with MySQL and PostgreSQL relational databases. It is up to five times faster than standard MySQL databases and up to three times faster than standard PostgreSQL databases.
    - Amazon Aurora helps to reduce your database costs by reducing unnecessary input/output (I/O) operations, while ensuring that your database resources remain reliable and available. 
    - Consider Amazon Aurora if your workloads require high availability. It replicates six copies of your data across three Availability Zones and continuously backs up your data to Amazon S3.

- *Amazon DynamoDB* is a key-value database service. It delivers single-digit millisecond performance at any scale.

- *Amazon Redshift* is a data warehousing service that you can use for big data analytics. It offers the ability to collect data from many sources and helps you to understand relationships and trends across your data.

- *AWS Database Migration Service *(AWS DMS) enables you to migrate relational databases, nonrelational databases, and other types of data stores. With AWS DMS, you move data between a source database and a target database. The source and target databases can be of the same type or different types. During the migration, your source database remains operational, reducing downtime for any applications that rely on the database. 

- *Amazon DocumentDB* is a document database service that supports MongoDB workloads. (MongoDB is a document database program.)

- *Amazon Neptune* is a graph database service. You can use Amazon Neptune to build and run applications that work with highly connected datasets, such as recommendation engines, fraud detection, and knowledge graphs.

- *Amazon Quantum Ledger Database* (Amazon QLDB) is a ledger database service. You can use Amazon QLDB to review a complete history of all the changes that have been made to your application data.

- *Amazon Managed Blockchain* is a service that you can use to create and manage blockchain networks with open-source frameworks. Blockchain is a distributed ledger system that lets multiple parties run transactions and share data without a central authority.

- *Amazon ElastiCache* is a service that adds caching layers on top of your databases to help improve the read times of common requests. It supports two types of data stores: Redis and Memcached.

- *Amazon DynamoDB Accelerator* (DAX) is an in-memory cache for DynamoDB. It helps improve response times from single-digit milliseconds to microseconds.


====================
Module 6: SECURITY
====================

- *AWS Identity and Access Management* (IAM) enables you to manage access to AWS services and resources securely. IAM gives you the flexibility to configure access based on your company’s specific operational and security needs.

- The root user is accessed by signing in with the email address and password that you used to create your AWS account. You can think of the root user as being similar to the owner of the coffee shop. It has complete access to all the AWS services and resources in the account.

- An *IAM user* is an identity that you create in AWS. It represents the person or application that interacts with AWS services and resources. It consists of a name and credentials. By default, when you create a new IAM user in AWS, it has no permissions associated with it. To allow the IAM user to perform specific actions in AWS, such as launching an Amazon EC2 instance or creating an Amazon S3 bucket, you must grant the IAM user the necessary permissions.

- An *IAM group* is a collection of IAM users. When you assign an IAM policy to a group, all users in the group are granted permissions specified by the policy.

- An *IAM role* is an identity that you can assume to gain temporary access to permissions. Before an IAM user, application, or service can assume an IAM role, they must be granted permissions to switch to the role. When someone assumes an IAM role, they abandon all previous permissions that they had under a previous role and assume the permissions of the new role. 

- Suppose that your company has multiple AWS accounts. You can use AWS Organizations to consolidate and manage multiple AWS accounts within a central location.

- In AWS Organizations, you can group accounts into organizational units (OUs) to make it easier to manage accounts with similar business or security requirements. When you apply a policy to an OU, all the accounts in the OU automatically inherit the permissions specified in the policy.  

- In AWS Organizations, you can apply service control policies (SCPs) to the organization root, an individual member account, or an OU. An SCP affects all IAM users, groups, and roles within an account, including the AWS account root user.

- You can apply IAM policies to IAM users, groups, or roles. You cannot apply an IAM policy to the AWS account root user

- AWS Artifact is a service that provides on-demand access to AWS security and compliance reports and select online agreements. AWS Artifact consists of two main sections: AWS Artifact Agreements and AWS Artifact Reports.

- AWS Shield is a service that protects applications against DDoS attacks. AWS Shield provides two levels of protection: Standard and Advanced.

- *AWS Key Management Service* (AWS KMS) enables you to perform encryption operations through the use of cryptographic keys. A cryptographic key is a random string of digits used for locking (encrypting) and unlocking (decrypting) data. You can use AWS KMS to create, manage, and use cryptographic keys. You can also control the use of keys across a wide range of services and in your applications.

- *AWS WAF* is a web application firewall that lets you monitor network requests that come into your web applications. AWS WAF works together with Amazon CloudFront and an Application Load Balancer. Recall the network access control lists that you learned about in an earlier module. AWS WAF works in a similar way to block or allow traffic. However, it does this by using a web access control list (ACL) to protect your AWS resources. 

- Amazon Inspector helps to improve the security and compliance of applications by running automated security assessments. It checks applications for security vulnerabilities and deviations from security best practices, such as open access to Amazon EC2 instances and installations of vulnerable software versions. 

- *Amazon GuardDuty* is a service that provides intelligent threat detection for your AWS infrastructure and resources. It identifies threats by continuously monitoring the network activity and account behavior within your AWS environment.

==========================
7. Monitering & Analytics
==========================

- *Amazon CloudWatch*:

    - Amazon CloudWatch is a web service that enables you to monitor and manage various metrics and configure alarm actions based on data from those metrics.
    - CloudWatch uses metrics to represent the data points for your resources. AWS services send metrics to CloudWatch. CloudWatch then uses these metrics to create graphs automatically that show how performance has changed over time. 
    - CloudWatch alarms-With CloudWatch, you can create alarms that automatically perform actions if the value of your metric has gone above or below a predefined threshold. 


- *AWS CloudTrail* records API calls for your account. The recorded information includes the identity of the API caller, the time of the API call, the source IP address of the API caller, and more. You can think of CloudTrail as a “trail” of breadcrumbs (or a log of actions) that someone has left behind them.
    - Track user activities and API requests throughout your AWS infrastructure
    - Filter logs to assist with operational analysis and troubleshooting

- *AWS Trusted Advisor* is a web service that inspects your AWS environment and provides real-time recommendations in accordance with AWS best practices. Trusted Advisor compares its findings to AWS best practices in five categories: cost optimization, performance, security, fault tolerance, and service limits. For the checks in each category, Trusted Advisor offers a list of recommended actions and additional resources to learn more about AWS best practices. 

===============
Pricing and Support
=================

- The AWS Free Tier enables you to begin using certain services without having to worry about incurring costs for the specified period. 
    - Three types of offers are available: Always Free, 12 Months Free, Trials.

- The *AWS Pricing Calculator* lets you explore AWS services and create an estimate for the cost of your use cases on AWS. You can organize your AWS estimates by groups that you define. A group can reflect how your company is organized, such as providing estimates by cost center.

- Use the AWS Billing & Cost Management dashboard to pay your AWS bill, monitor your usage, and analyze and control your costs.

- AWS Budgets

    - In AWS Budgets, you can create budgets to plan your service usage, service costs, and instance reservations.

    - The information in AWS Budgets updates three times a day. This helps you to accurately determine how close your usage is to your budgeted amounts or to the AWS Free Tier limits.

    - In AWS Budgets, you can also set custom alerts when your usage exceeds (or is forecasted to exceed) the budgeted amount.

- AWS Cost Explorer

    - AWS Cost Explorer is a tool that enables you to visualize, understand, and manage your AWS costs and usage over time.

    - AWS Cost Explorer includes a default report of the costs and usage for your top five cost-accruing AWS services. You can apply custom filters and groups to analyze your data. For example, you can view resource usage at the hourly level.

- AWS Support

    - AWS offers four different Support plans to help you troubleshoot issues, lower costs, and efficiently use AWS services. 
    - You can choose from the following Support plans to meet your company’s needs: 
        - Basic
        - Developer
        - Business
        - Enterprise On-Ramp
        - Enterprise

- *Technical Account Manager (TAM)*

    - The Enterprise On-Ramp and Enterprise Support plans include access to a Technical Account Manager (TAM).
    - The TAM is your primary point of contact at AWS. If your company subscribes to Enterprise Support or Enterprise On-Ramp, your TAM educates, empowers, and evolves your cloud journey across the full range of AWS services. TAMs provide expert engineering guidance, help you design solutions that efficiently integrate AWS services, assist with cost-effective and resilient architectures, and provide direct access to AWS programs and a broad community of experts.

- *AWS Marketplace* is a digital catalog that includes thousands of software listings from independent software vendors. You can use AWS Marketplace to find, test, and buy software that runs on AWS. For each listing in AWS Marketplace, you can access detailed information on pricing options, available support, and reviews from other AWS customers.

===================
Migrations
===================

- *AWS Cloud Adoption Framework* (AWS CAF) organizes guidance into six areas of focus, called Perspectives. Each Perspective addresses distinct responsibilities. The planning process helps the right people across the organization prepare for the changes ahead.
    - In general, the Business, People, and Governance Perspectives focus on business capabilities, whereas the Platform, Security, and Operations Perspectives focus on technical capabilities.

- 6 strategies for migration, When migrating applications to the cloud, six of the most common migration strategies that you can implement are:

    - Rehosting
    - Replatforming
    - Refactoring/re-architecting
    - Repurchasing
    - Retaining
    - Retiring


- AWS Snow Family members

    - The AWS Snow Family is a collection of physical devices that help to physically transport up to exabytes of data into and out of AWS. 

    - AWS Snow Family is composed of AWS Snowcone, AWS Snowball, and AWS Snowmobile. 

- The AWS Well-Architected Framework

    - The AWS Well-Architected Framework helps you understand how to design and operate reliable, secure, efficient, and cost-effective systems in the AWS Cloud. It provides a way for you to consistently measure your architecture against best practices and design principles and identify areas for improvement.
    - The Well-Architected Framework is based on six pillars: 
        - Operational excellence
        - Security
        - Reliability
        - Performance efficiency
        - Cost optimization
        - Sustainability

- Advantages of cloud computing

    - Operating in the AWS Cloud offers many benefits over computing in on-premises or hybrid environments. 

    - In this section, you will learn about six advantages of cloud computing:

        - Trade upfront expense for variable expense.
        - Benefit from massive economies of scale.
        - Stop guessing capacity.
        - Increase speed and agility.
        - Stop spending money running and maintaining data centers.
        - Go global in minutes.