The lab assignment focuses on building and configuring a network infrastructure using Terraform on Google Cloud Platform (GCP). The primary tasks involve setting up Virtual Private Clouds (VPCs), creating a VXLAN tunnel for routing traffic, and configuring Network Address Translation (NAT) to enable internet access for instances without public IP addresses.

### **Lab Overview**

You will create two VPCs, each with a virtual machine (VM) inside a subnet using the private address space `172.16.x.x`. The goal is to configure these VPCs and VMs such that traffic can be routed from one VM through the other and out to the internet, even though neither VM has a public IP address.

### **Steps Involved**

#### 1. **Set Up the Infrastructure Using Terraform**
   - **VPC Creation**: Create two VPCs (`vpc1` and `vpc2`) using Terraform. Each VPC will contain a subnet and a VM. All resources should be prefixed with `tf-mod3-lab1-`.
   - **Subnets and VMs**: Assign subnets within the 172.16 address space to each VPC, and launch a VM in each subnet.

#### 2. **Configure VPC Peering**
   - Establish VPC peering between `vpc1` and `vpc2` to allow internal communication over private IP addresses.

#### 3. **Set Up a VXLAN Tunnel**
   - **On VM1**:
     - Create a VXLAN tunnel device using the command: 
       ```bash
       sudo ip link add vxlan0 type vxlan id 5001 local 172.16.0.2 remote 172.16.1.2 dev ens4 dstport 50000
       sudo ip addr add 192.168.100.2/24 dev vxlan0
       sudo ip link set up dev vxlan0
       ```
     - This command creates a virtual network interface (`vxlan0`) that encapsulates Layer 2 frames inside Layer 3 packets, allowing traffic to be routed between the VMs.

   - **On VM2**:
     - Set up the VXLAN tunnel similarly, but with reversed local and remote IP addresses:
       ```bash
       sudo ip link add vxlan0 type vxlan id 5001 remote 172.16.0.2 local 172.16.1.2 dev ens4 dstport 50000
       sudo ip addr add 192.168.100.3/24 dev vxlan0
       sudo ip link set up dev vxlan0
       ```

#### 4. **Configure NAT on VM2**
   - Enable IP forwarding on VM2 to allow it to route traffic:
     ```bash
     sudo /sbin/sysctl -w net.ipv4.ip_forward=1
     ```
   - Set up NAT using IP tables to masquerade the traffic going out to the internet:
     ```bash
     sudo /sbin/iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o ens4 -j MASQUERADE
     ```

#### 5. **Set Up Routing**
   - **On VM1**:
     - Add a route for the traffic destined for the external IP address of `neverssl.com` to go through the VXLAN tunnel and be routed via VM2:
       ```bash
       sudo ip route add 34.223.124.45/32 via 192.168.100.3
       ```

#### 6. **Test Connectivity**
   - Use `wget` to fetch a resource from `neverssl.com`:
     ```bash
     wget 34.223.124.45
     ```
   - Verify the download, check the contents, and run additional commands like pinging an external IP to confirm the setup.

#### 7. **Terraform and JQ Queries**
   - Run `terraform show --json > terraform_show_out.json` to output the Terraform state in JSON format.
   - Use `jq` to query specific details from the Terraform state, such as the state of network peering and network addresses.

