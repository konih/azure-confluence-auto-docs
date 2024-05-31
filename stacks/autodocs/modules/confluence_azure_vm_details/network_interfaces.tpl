<h3>🌐 Network Interfaces</h3>
<p></p>
%{ for network_interface in network_interfaces }
<h4>Interface ID: ${network_interface.id}</h4>
<p></p>
<table>
  <tr>
    <th>Parameter</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>🌍 Location</td>
    <td>${network_interface.location}</td>
  </tr>
  <tr>
    <td>🔒 Network Security Group ID</td>
    <td>${network_interface.network_security_group_id}</td>
  </tr>
  <tr>
    <td>🔗 Private IP Address</td>
    <td>${network_interface.private_ip_address}</td>
  </tr>
  %{ if try(network_interface.public_ip_address, null) != null }
  <tr>
    <td>🔗 Public IP Address</td>
    <td>${network_interface.public_ip_address}</td>
  </tr>
  %{ endif }
  <tr>
    <td>🔗 Subnet ID</td>
    <td>${network_interface.subnet_id}</td>
  </tr>
  <tr>
    <td>💻 MAC Address</td>
    <td>${network_interface.mac_address}</td>
  </tr>
  <tr>
    <td>🔗 Applied DNS Servers</td>
    <td>
      <ul>
        %{ for dns in network_interface.applied_dns_servers }
          <li>${dns}</li>
        %{ endfor }
      </ul>
    </td>
  </tr>
  <tr>
    <td>🔗 IP Configurations</td>
    <td>
      <ul>
        %{ for name, config in network_interface.ip_configurations }
          <li>${name}: ${config.private_ip_address}</li>
        %{ endfor }
      </ul>
    </td>
  </tr>
</table>
%{ endfor }